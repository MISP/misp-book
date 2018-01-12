# MISP and Internationalization (i18n)

## Requirements

Please read the following CakePHP documentation about i18n & l10n: https://book.cakephp.org/2.0/en/core-libraries/internationalization-and-localization.html

## Add one .md per translation effort

Please add a file à la: ja_JP.md (Japanese_Japan) or it_CH.md (Italian_Switzerland), in which you briefly describe what the current status of your translation effort is and what has been translated and which parts might be gotchas.

## Style

Please follow whatever is the purest and most intelligible form of written language.

## Formatting

It is important to use correct formatting. This is wrong:

```
<p><?php echo __('Are you sure you want to delete Proposal #') . $id . '?' ?></p>
```

You want to have ultimate flexibility and that line should look more like this:

```
<p><?php echo __('Are you sure you want to delete Proposal #%s?', $id);?></p>
```

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
