local M = {}

local STROKE = 'fill="none" stroke="currentColor" stroke-width="1.5" ' ..
               'stroke-linecap="round" stroke-linejoin="round"'
local FILL = 'fill="currentColor"'

local function svg(body, filled)
  return ('<svg class="cite-this-icon" viewBox="0 0 24 24" width="16" height="16" ' ..
          'aria-hidden="true" focusable="false" %s>%s</svg>')
    :format(filled and FILL or STROKE, body)
end

-- Aspas de abertura: duas gotas sólidas. É a marca da extensão.
M.quote = svg('<path d="M9.9 5.2C6.7 6.7 4.8 9.5 4.8 12.9v5.9h6.5v-6.6H8.1c.1-1.9 1.1-3.3 2.7-4.3L9.9 5.2z' ..
              'M19.3 5.2c-3.2 1.5-5.1 4.3-5.1 7.7v5.9h6.5v-6.6h-3.2c.1-1.9 1.1-3.3 2.7-4.3l-.9-2.7z"/>', true)

-- Três linhas com recuo pendente: o ícone é um verbete de bibliografia.
M.text = svg('<path d="M3 6h18M6 11.5h15M6 17h11"/>')

-- Chaves de arquivo .bib. A primeira versão preenchia o miolo com duas
-- linhas de campo finas (a marcação de um registro .bib de verdade), mas a
-- 16px as duas linhas coladas viravam um borrão ilegível — lido como "{-}"
-- nas capturas. Chaves grandes e limpas, sem detalhe interno, permanecem
-- nítidas nesse tamanho (o mesmo motivo por que ícones de "chaves"/código
-- de bibliotecas de ícone popular evitam ornamento no miolo); a leitura de
-- "arquivo .bib" fica por conta do rótulo/aria-label do botão, como já
-- acontece com os demais ícones do conjunto.
M.bibtex = svg('<path d="M10 4c-2.2 0-3 1.1-3 3.2v2.3c0 1.6-.6 2.5-2 2.5 1.4 0 2 .9 2 2.5v2.3c0 2.1.8 3.2 3 3.2' ..
               'M14 4c2.2 0 3 1.1 3 3.2v2.3c0 1.6.6 2.5 2 2.5-1.4 0-2 .9-2 2.5v2.3c0 2.1-.8 3.2-3 3.2"/>')

M.copy = svg('<rect x="9" y="9" width="12" height="12" rx="2.5"/>' ..
             '<path d="M5.5 15H4.5A2.5 2.5 0 0 1 2 12.5v-8A2.5 2.5 0 0 1 4.5 2h8A2.5 2.5 0 0 1 15 4.5v1"/>')

M.download = svg('<path d="M12 3v11m0 0 4-4m-4 4-4-4"/>' ..
                 '<path d="M4 16.5v2A2.5 2.5 0 0 0 6.5 21h11a2.5 2.5 0 0 0 2.5-2.5v-2"/>')

M.check = svg('<path d="M4 12.5 9 17.5 20 6.5"/>')

-- Controle de opções (escolher escopo e estilo): três trilhas horizontais
-- com um botão deslizante cada, em alturas alternadas — o pictograma comum
-- para "ajustes"/"opções", mais legível que uma seta de dropdown solta e com
-- peso visual simétrico (ao contrário do caret, que pesava para baixo e
-- lia como desalinhado ao lado dos outros ícones).
M.options = svg('<path d="M3 6h10M17 6h4M3 12h4M11 12h10M3 18h10M17 18h4"/>' ..
               '<circle cx="15" cy="6" r="2" fill="currentColor" stroke="none"/>' ..
               '<circle cx="7.5" cy="12" r="2" fill="currentColor" stroke="none"/>' ..
               '<circle cx="15" cy="18" r="2" fill="currentColor" stroke="none"/>')

return M
