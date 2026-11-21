/* cite-this — troca de variante, cópia e posicionamento.
   Nenhuma dependência externa. */
(function () {
  "use strict";

  var STORE_SCOPE = "cite-this:scope";
  var STORE_STYLE = "cite-this:style";

  var TARGETS = {
    "margin-sidebar": [
      "#quarto-margin-sidebar .toc-actions",
      "#quarto-margin-sidebar nav",
      "#quarto-margin-sidebar",
      ".sidebar.margin-sidebar"
    ],
    sidebar: [
      "#quarto-sidebar .sidebar-menu-container",
      "#quarto-sidebar",
      ".sidebar.sidebar-navigation .sidebar-menu-container",
      ".sidebar.sidebar-navigation"
    ],
    navbar: [
      ".navbar .quarto-navbar-tools",
      ".navbar .navbar-nav.ms-auto",
      ".navbar .navbar-nav",
      ".navbar .navbar-container"
    ]
  };

  // Suporte à Popover API (Chrome 114+, Safari 17+, Firefox 125+): quando
  // disponível é a rota preferida para o painel do menu de opções, porque
  // promove o elemento ao top layer e escapa de overflow, clip-path,
  // transform e contexto de empilhamento de qualquer ancestral — inclusive
  // a rolagem própria da sidebar do TOC. Sem isso, cai no recuo de
  // position: fixed com coordenadas calculadas (ver positionPanel).
  var HAS_POPOVER = typeof HTMLElement !== "undefined" &&
    typeof HTMLElement.prototype.showPopover === "function";

  function firstTarget(names) {
    for (var i = 0; i < names.length; i++) {
      var el = document.querySelector(names[i]);
      if (el) return el;
    }
    return null;
  }

  function remembers(root) {
    return root.getAttribute("data-remember") === "true";
  }

  function readStored(root, key, fallback) {
    if (!remembers(root)) return fallback;
    try {
      var v = window.localStorage.getItem(key);
      return v === null ? fallback : v;
    } catch (e) {
      return fallback;
    }
  }

  function store(root, key, value) {
    if (!remembers(root)) return;
    try { window.localStorage.setItem(key, value); } catch (e) { /* modo privado */ }
  }

  function variants(root) {
    return root.querySelectorAll(".cite-this-variant");
  }

  // Verifica existência de variante por campo do dataset (ex.: "scope",
  // "style"), comparando valores em JS em vez de montar seletor CSS por
  // concatenação de string — scope/style podem vir do localStorage
  // (readStored), e um valor com aspas quebraria um seletor concatenado.
  function hasVariant(root, field, value) {
    var nodes = variants(root);
    for (var i = 0; i < nodes.length; i++) {
      if (nodes[i].dataset[field] === value) return true;
    }
    return false;
  }

  // Acha um <input> por name+value comparando .value em JS: o name é sempre
  // um literal do próprio código (seguro para concatenar), mas o value pode
  // vir do localStorage — nunca entra num seletor CSS.
  function findRadio(root, name, value) {
    var nodes = root.querySelectorAll('input[name="' + name + '"]');
    for (var i = 0; i < nodes.length; i++) {
      if (nodes[i].value === value) return nodes[i];
    }
    return null;
  }

  function state(root) {
    return {
      scope: root.getAttribute("data-scope") === "both"
        ? root.dataset.activeScope || root.getAttribute("data-default-scope")
        : root.getAttribute("data-default-scope"),
      style: root.dataset.activeStyle || root.getAttribute("data-default-style"),
      kind: root.dataset.activeKind || "text"
    };
  }

  // Filtra os nós pelo dataset em vez de montar seletor CSS por
  // concatenação: kind/scope/style podem carregar valor restaurado do
  // localStorage, e um valor com aspas quebraria um seletor concatenado
  // (SyntaxError síncrono em querySelector).
  function pick(root, kind, scope, style) {
    var nodes = variants(root);
    for (var i = 0; i < nodes.length; i++) {
      var el = nodes[i];
      if (el.dataset.kind !== kind) continue;
      if (el.dataset.scope !== scope) continue;
      if (kind === "text" && el.dataset.style !== style) continue;
      return el;
    }
    return null;
  }

  function apply(root) {
    var s = state(root);
    var target = pick(root, s.kind, s.scope, s.style)
      || pick(root, "text", s.scope, s.style)
      || root.querySelector(".cite-this-variant");
    if (!target) return;

    variants(root).forEach(function (el) { el.hidden = el !== target; });

    var preview = root.querySelector(".cite-this-preview");
    if (preview) {
      var rendered = pick(root, "text", s.scope, s.style);
      preview.innerHTML = rendered
        ? rendered.querySelector(".cite-this-rendered").innerHTML
        : "";
    }

    root.querySelectorAll(".cite-this-tab").forEach(function (tab) {
      if (tab.hasAttribute("data-tab-scope")) {
        var scopeSelected = tab.getAttribute("data-tab-scope") === s.scope;
        tab.setAttribute("aria-selected", String(scopeSelected));
        tab.tabIndex = scopeSelected ? 0 : -1;
      }
      if (tab.hasAttribute("data-tab-kind")) {
        var kindSelected = tab.getAttribute("data-tab-kind") === s.kind;
        tab.setAttribute("aria-selected", String(kindSelected));
        tab.tabIndex = kindSelected ? 0 : -1;
      }
    });

    // Estilo CSL só altera a citação formatada. No modo BibTeX ele não tem
    // efeito, portanto esconder o seletor evita sugerir uma relação que não
    // existe. Sem JavaScript o modo inicial é Texto e o seletor fica visível.
    var styleWrap = root.querySelector("[data-cite-this-style-wrap]");
    if (styleWrap) styleWrap.hidden = s.kind !== "text";

    // O botão do rodapé copia o formato ativo; seu nome acessível acompanha
    // a aba para não anunciar "Copy citation" quando vai copiar BibTeX.
    var activeCopy = root.querySelector('[data-cite-this-action="active"]');
    if (activeCopy) {
      var copyLabel = root.getAttribute(s.kind === "bibtex"
        ? "data-copy-bibtex-label" : "data-copy-text-label");
      if (copyLabel) {
        activeCopy.setAttribute("title", copyLabel);
        activeCopy.setAttribute("aria-label", copyLabel);
      }
    }
  }

  function textOf(node) {
    if (!node) return "";
    // .cite-this-text é sempre texto puro (às vezes um <pre> de BibTeX, cujas
    // quebras de linha importam) — nunca .cite-this-rendered, que carrega
    // marcação HTML (itálico etc.) destinada só à exibição.
    var plain = node.querySelector(".cite-this-text");
    return (plain ? plain.textContent : node.textContent).trim();
  }

  function fallbackCopy(text) {
    var ta = document.createElement("textarea");
    ta.value = text;
    ta.setAttribute("readonly", "");
    ta.style.position = "fixed";
    ta.style.opacity = "0";
    document.body.appendChild(ta);
    ta.select();
    var ok = false;
    try { ok = document.execCommand("copy"); } catch (e) { ok = false; }
    document.body.removeChild(ta);
    return ok;
  }

  function copy(text) {
    // navigator.clipboard só existe em contexto seguro (https ou localhost);
    // um book aberto via file:// cai direto no fallback de <textarea>.
    if (navigator.clipboard && window.isSecureContext) {
      return navigator.clipboard.writeText(text).catch(function () {
        return fallbackCopy(text) ? undefined : Promise.reject();
      });
    }
    return fallbackCopy(text) ? Promise.resolve() : Promise.reject();
  }

  // Região de status por widget: anuncia a cópia para leitor de tela sem
  // depender do ícone de confirmação, que é puramente decorativo
  // (aria-hidden, como todo ícone de icons.lua). Fica fora de qualquer
  // <details> do próprio widget para não ser silenciada quando ele está
  // fechado (ver cite-this-collapse).
  function announcer(root) {
    var el = root.querySelector(".cite-this-status");
    if (!el) {
      el = document.createElement("span");
      el.className = "cite-this-status";
      el.setAttribute("role", "status");
      el.setAttribute("aria-live", "polite");
      root.appendChild(el);
    }
    return el;
  }

  function flash(root, button) {
    button.classList.add("is-copied");
    // data-copied-label vem de widget.lua (terms.copied já traduzido) — o
    // texto de interface vive só no i18n.lua, o JS não duplica dicionário.
    // Se por algum motivo o atributo não existir, só pula o anúncio sonoro;
    // o feedback visual (is-copied) continua acontecendo de qualquer forma.
    var label = root.getAttribute("data-copied-label");
    if (label) {
      var status = announcer(root);
      // Limpa antes de escrever: garante que leitores de tela anunciem mesmo
      // quando o texto repete a última cópia (mutação vazio -> texto).
      status.textContent = "";
      window.setTimeout(function () { status.textContent = label; }, 20);
    }
    window.setTimeout(function () {
      button.classList.remove("is-copied");
      var status = root.querySelector(".cite-this-status");
      if (status) status.textContent = "";
    }, 1200);
  }

  function download(root) {
    var s = state(root);
    var node = pick(root, "bibtex", s.scope);
    if (!node) return;
    var name = node.getAttribute("data-filename") || "citation.bib";
    var blob = new Blob([textOf(node) + "\n"], { type: "application/x-bibtex;charset=utf-8" });
    var url = URL.createObjectURL(blob);
    var a = document.createElement("a");
    a.href = url;
    a.download = name;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    window.setTimeout(function () { URL.revokeObjectURL(url); }, 0);
  }

  // Radios sem <form> própria formam um único grupo por name() no documento
  // inteiro (spec de radio button group): duas instâncias de .cite-this na
  // mesma página (ex.: o widget de ações + um bloco inline via shortcode)
  // compartilhariam name="cite-this-style"/"cite-this-scope" e marcar uma
  // desmarcaria a outra silenciosamente. Envolve o painel num <form> só em
  // memória (nunca submetido) para isolar o grupo por widget.
  function isolateRadioGroup(root) {
    var panel = root.querySelector(".cite-this-panel");
    if (!panel || panel.closest("form")) return;
    var form = document.createElement("form");
    form.className = "cite-this-formscope";
    form.addEventListener("submit", function (ev) { ev.preventDefault(); });
    panel.parentNode.insertBefore(form, panel);
    form.appendChild(panel);
  }

  // Calcula e aplica a posição do painel do menu em coordenadas de viewport
  // (position: fixed), invertendo de lado e de direção para caber na tela.
  // Usada nas duas rotas: com Popover (que já escapa de overflow/recorte por
  // conta do top layer, mas segue precisando de left/top) e no recuo sem
  // Popover, onde position: fixed é a própria correção — só que aí vale a
  // ressalva conhecida: um ancestral com transform, filter ou will-change
  // cria bloco contentor próprio e o fixed passa a ser relativo a ele, não à
  // viewport. Fora do alcance deste recuo; a rota com Popover não tem esse
  // problema, por isso é a preferida sempre que existe.
  function positionPanel(trigger, panel) {
    var margin = 8;
    panel.style.left = "0px";
    panel.style.top = "0px";
    var tRect = trigger.getBoundingClientRect();
    var pRect = panel.getBoundingClientRect();
    var vw = document.documentElement.clientWidth;
    var vh = document.documentElement.clientHeight;

    var left = tRect.left;
    if (left + pRect.width > vw - margin) {
      left = tRect.right - pRect.width;
    }
    if (left < margin) left = margin;

    var top = tRect.bottom + 4;
    var flippedUp = false;
    if (top + pRect.height > vh - margin) {
      var above = tRect.top - 4 - pRect.height;
      if (above >= margin) {
        top = above;
        flippedUp = true;
      } else {
        // Não cabe nem embaixo nem em cima (viewport baixa, ex.: celular em
        // paisagem): encosta no topo da viewport em vez de vazar por ambos
        // os lados; .cite-this-preview já rola por dentro se o conteúdo for
        // alto demais.
        top = Math.max(margin, vh - margin - pRect.height);
      }
    }

    panel.style.left = left + "px";
    panel.style.top = top + "px";
    panel.classList.toggle("cite-this-panel--flip-up", flippedUp);
  }

  function openPanel(panel) {
    if (HAS_POPOVER) {
      if (!panel.hasAttribute("popover")) panel.setAttribute("popover", "manual");
      if (!panel.matches(":popover-open")) {
        try { panel.showPopover(); } catch (e) { /* já aberto */ }
      }
    } else {
      // Recuo sem Popover: a mesma correção (coordenadas em viewport) via
      // position: fixed comum, sem promoção a top layer.
      panel.style.position = "fixed";
    }
  }

  function closePanel(panel) {
    if (HAS_POPOVER && panel.hasAttribute("popover") && panel.matches(":popover-open")) {
      try { panel.hidePopover(); } catch (e) { /* já fechado */ }
    }
  }

  // Em dispositivos sem hover, a pílula usa estado explícito: começa
  // circular, o primeiro toque no botão principal expande as ações e não
  // dispara a ação ainda. Um segundo toque já opera o botão normalmente.
  // Desktop não passa por esta rota e conserva hover/foco no CSS.
  function wireTouchPill(root) {
    if (!root.classList.contains("cite-this--mount") || !window.matchMedia) return;

    var hoverless = window.matchMedia("(hover: none)");
    var actions = root.querySelector(".cite-this-actions");
    var collapsible = root.querySelector(".cite-this-collapsible");
    var lead = actions && actions.firstElementChild;
    var leadControl = lead && (lead.matches("button, summary")
      ? lead : lead.querySelector("button, summary"));
    var menu = root.querySelector(".cite-this-menu");
    if (!actions || !collapsible || !lead || !leadControl) return;

    function setExpanded(expanded) {
      root.classList.toggle("is-expanded", expanded);
      leadControl.setAttribute("aria-expanded", String(expanded));
      if (expanded) {
        collapsible.removeAttribute("inert");
        collapsible.removeAttribute("aria-hidden");
      } else {
        if (menu) menu.open = false;
        if (collapsible.contains(document.activeElement)) {
          try { leadControl.focus({ preventScroll: true }); } catch (e) { leadControl.focus(); }
        }
        collapsible.setAttribute("inert", "");
        collapsible.setAttribute("aria-hidden", "true");
      }
    }

    function syncMode() {
      if (hoverless.matches) {
        setExpanded(false);
      } else {
        root.classList.remove("is-expanded");
        leadControl.removeAttribute("aria-expanded");
        collapsible.removeAttribute("inert");
        collapsible.removeAttribute("aria-hidden");
      }
    }

    // Registra antes do manipulador das ações em wire(): o primeiro toque
    // expande a pílula sem copiar/baixar acidentalmente. Já expandida, o
    // evento segue para a ação original.
    root.addEventListener("click", function (ev) {
      if (!hoverless.matches || root.classList.contains("is-expanded")) return;
      if (!lead.contains(ev.target)) return;
      ev.preventDefault();
      ev.stopImmediatePropagation();
      setExpanded(true);
    });

    document.addEventListener("click", function (ev) {
      if (!hoverless.matches || !root.classList.contains("is-expanded")) return;
      if (!root.contains(ev.target)) setExpanded(false);
    });

    // Somente a rolagem da página fecha a pílula; rolar a prévia dentro do
    // popup continua possível sem desmontar o controle.
    window.addEventListener("scroll", function () {
      if (hoverless.matches && root.classList.contains("is-expanded")) {
        setExpanded(false);
      }
    });

    if (typeof hoverless.addEventListener === "function") {
      hoverless.addEventListener("change", syncMode);
    } else if (typeof hoverless.addListener === "function") {
      hoverless.addListener(syncMode);
    }
    syncMode();
  }

  function wire(root) {
    isolateRadioGroup(root);
    wireTouchPill(root);

    root.addEventListener("click", function (ev) {
      var button = ev.target.closest("[data-cite-this-action]");
      if (!button || !root.contains(button)) return;
      var action = button.getAttribute("data-cite-this-action");
      var s = state(root);

      if (action === "download") { download(root); return; }

      var kind = action === "active" ? s.kind : action;
      var node = pick(root, kind, s.scope, s.style);
      var text = textOf(node);
      if (!text) return;

      copy(text).then(function () { flash(root, button); }).catch(function () { /* silêncio */ });
    });

    root.addEventListener("change", function (ev) {
      var input = ev.target;
      if (input.name === "cite-this-scope") {
        root.dataset.activeScope = input.value;
        store(root, STORE_SCOPE, input.value);
        apply(root);
      } else if (input.name === "cite-this-style") {
        root.dataset.activeStyle = input.value;
        store(root, STORE_STYLE, input.value);
        apply(root);
      } else if (input.hasAttribute("data-cite-this-style")) {
        root.dataset.activeStyle = input.value;
        store(root, STORE_STYLE, input.value);
        apply(root);
      }
    });

    root.querySelectorAll(".cite-this-tab").forEach(function (tab) {
      tab.addEventListener("click", function () {
        if (tab.hasAttribute("data-tab-scope")) {
          root.dataset.activeScope = tab.getAttribute("data-tab-scope");
          store(root, STORE_SCOPE, root.dataset.activeScope);
        } else if (tab.hasAttribute("data-tab-kind")) {
          root.dataset.activeKind = tab.getAttribute("data-tab-kind");
        }
        apply(root);
      });
    });

    // Padrão ARIA de tablist: apenas a aba ativa participa da ordem normal
    // de foco; setas navegam e ativam, Home/End saltam para as extremidades.
    root.querySelectorAll('.cite-this-tabs[role="tablist"]').forEach(function (tablist) {
      tablist.addEventListener("keydown", function (ev) {
        if (["ArrowLeft", "ArrowRight", "Home", "End"].indexOf(ev.key) < 0) return;
        var tabs = Array.prototype.slice.call(tablist.querySelectorAll('[role="tab"]'));
        if (tabs.length < 2) return;
        var current = tabs.indexOf(document.activeElement);
        if (current < 0) return;
        ev.preventDefault();
        var next = ev.key === "Home" ? 0
          : ev.key === "End" ? tabs.length - 1
          : ev.key === "ArrowRight" ? (current + 1) % tabs.length
          : (current - 1 + tabs.length) % tabs.length;
        tabs[next].click();
        tabs[next].focus();
      });
    });

    // O painel do menu não pode vazar da janela (ver positionPanel/openPanel
    // acima do wire): a sidebar do TOC tem rolagem própria, e a pílula
    // flutuante fica perto do rodapé — os dois recortam ou empurram um
    // painel position: absolute comum para fora da viewport.
    var menu = root.querySelector(".cite-this-menu");
    if (menu) {
      var trigger = menu.querySelector("summary.cite-this-btn");
      var panel = menu.querySelector(".cite-this-panel");

      menu.addEventListener("toggle", function () {
        if (!trigger || !panel) return;
        // O painel promovido ao top layer continua descendente da pílula no
        // DOM, mas alguns navegadores perdem :hover durante o mousedown de
        // controles nativos (especialmente radios). Sem um estado explícito,
        // .cite-this-collapsible volta por um instante a pointer-events:none:
        // o clique atravessa para a página, dispara mouseleave e não chega a
        // produzir change. Mantém a pílula interativa por todo o ciclo aberto.
        root.classList.toggle("is-panel-open", menu.open);
        if (menu.open) {
          openPanel(panel);
          positionPanel(trigger, panel);
        } else {
          closePanel(panel);
        }
      });

      // A sidebar do TOC rola por conta própria e a janela pode ser
      // redimensionada com o menu aberto; reposiciona nos dois casos em vez
      // de deixar o painel desalinhado do gatilho.
      var reflow = function () {
        if (menu.open && trigger && panel) positionPanel(trigger, panel);
      };
      document.addEventListener("scroll", reflow, true);
      window.addEventListener("resize", reflow);

      document.addEventListener("keydown", function (ev) {
        if (ev.key === "Escape" && menu.open) {
          menu.open = false;
          if (trigger) trigger.focus();
        }
      });

      // Interações dentro ou fora do painel não devem fechá-lo por clique:
      // isso interromperia a troca de escopo/estilo antes de o estado visual
      // ser percebido. Para o ponteiro, encerra somente quando ele sai do
      // próprio painel; teclado continua contando com Escape e o summary
      // nativo alterna o menu quando seu gatilho é ativado novamente.
      panel.addEventListener("mouseleave", function () {
        if (menu.open) menu.open = false;
      });
    }
  }

  function restore(root) {
    if (root.getAttribute("data-scope") === "both") {
      var scope = readStored(root, STORE_SCOPE, root.getAttribute("data-default-scope"));
      if (hasVariant(root, "scope", scope)) {
        root.dataset.activeScope = scope;
        var radio = findRadio(root, "cite-this-scope", scope);
        if (radio) radio.checked = true;
      }
    }
    var style = readStored(root, STORE_STYLE, root.getAttribute("data-default-style"));
    if (hasVariant(root, "style", style)) {
      root.dataset.activeStyle = style;
      var styleRadio = findRadio(root, "cite-this-style", style);
      if (styleRadio) styleRadio.checked = true;
      var select = root.querySelector("[data-cite-this-style]");
      if (select) select.value = style;
    }
  }

  // position: title — logo abaixo do título da página/capítulo. O alvo
  // confirmado no HTML renderizado pelo Quarto é
  // header#title-block-header > div.quarto-title > h1.title, com
  // div.quarto-title-meta como próximo irmão. Insere depois de
  // div.quarto-title (dentro do header); se esse wrapper não existir em
  // algum tema, recua para logo depois de h1.title; se nada disso existir,
  // quem chama cai para o modo flutuante.
  function mountTitle(root) {
    var header = document.querySelector("#title-block-header");
    if (!header) return false;
    var titleDiv = header.querySelector(":scope > div.quarto-title");
    var anchor = titleDiv || header.querySelector("h1.title");
    if (!anchor) return false;
    var host = anchor.parentNode;
    if (anchor.nextSibling) {
      host.insertBefore(root, anchor.nextSibling);
    } else {
      host.appendChild(root);
    }
    return true;
  }

  function mount(root) {
    var position = root.getAttribute("data-position");
    root.hidden = false;

    // Normaliza os nomes direcionais experimentais para a terminologia usada
    // pelo próprio Quarto: sidebar (esquerda) e margin-sidebar (direita).
    if (position === "sidebar-left") {
      position = "sidebar";
      root.setAttribute("data-position", position);
    }
    if (position === "sidebar-right") {
      position = "margin-sidebar";
      root.setAttribute("data-position", position);
    }

    if (position === "sidebar" || position === "margin-sidebar" || position === "navbar") {
      var host = firstTarget(TARGETS[position]);
      if (host) {
        if (host.tagName === "UL" || host.tagName === "OL") {
          var li = document.createElement("li");
          li.className = "cite-this-host";
          li.appendChild(root);
          host.appendChild(li);
        } else {
          host.appendChild(root);
        }
        return;
      }
      // eslint-disable-next-line no-console
      console.warn("[cite-this] alvo de '" + position + "' não encontrado; usando o modo flutuante");
      position = "floating";
    }

    if (position === "title") {
      if (mountTitle(root)) return;
      // eslint-disable-next-line no-console
      console.warn("[cite-this] alvo de 'title' não encontrado; usando o modo flutuante");
      position = "floating";
    }

    if (position === "floating") {
      root.classList.add("cite-this--floating");
      document.body.appendChild(root);
    }
  }

  // Isola cada chamada por widget: se uma delas lançar (ex.: um valor
  // corrompido em algum lugar inesperado), os demais widgets — e as demais
  // etapas do MESMO widget — continuam rodando em vez de o forEach inteiro
  // parar no primeiro erro não tratado. Nunca falha em silêncio: registra
  // no console.
  function safely(label, fn) {
    try {
      fn();
    } catch (e) {
      // eslint-disable-next-line no-console
      console.error("[cite-this] " + label + " falhou para um widget:", e);
    }
  }

  function init() {
    document.querySelectorAll(".cite-this--mount").forEach(function (root) {
      safely("mount()", function () { mount(root); });
    });
    document.querySelectorAll(".cite-this").forEach(function (root) {
      safely("restore()", function () { restore(root); });
      safely("wire()", function () { wire(root); });
      safely("apply()", function () { apply(root); });
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
