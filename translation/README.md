# MISP and Internationalization (i18n)

## Requirements

Please read the following CakePHP documentation about i18n & l10n: https://book.cakephp.org/2.0/en/core-libraries/internationalization-and-localization.html

## Add an .md per translation effort

Please add a file à la: ja_JP.md (Japanese_Japan) or it_CH.md (Italian_Switzerland), in which you briefly describe what the current status is and what has been translated and which parts might be gotchas.

## Quirks

Lines like this:

```
echo $this->Form->button('Submit', array('class' => 'btn btn-primary'));$
```

Should be prepared as such:

```
echo $this->Form->button(__('Submit'), array('class' => 'btn btn-primary'));
```

Or another case:

```
echo $this->Form->input('sharing_group_id', array(
    'options' => array($sharingGroups),
    'label' => 'Sharing Group',
));
```

To:

```
echo $this->Form->input('sharing_group_id', array(
    'options' => array($sharingGroups),
    'label' => __('Sharing Group'),
));
```


## Let us know!

If you plan to do a translation or localization, please open a ticket on the issue system: https://github.com/MISP/MISP-book/issues
