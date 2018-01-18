# MISP and Internationalization (i18n)

## Requirements

Please read the following CakePHP documentation about i18n & l10n: https://book.cakephp.org/2.0/en/core-libraries/internationalization-and-localization.html

## Add one .md per translation effort

Please add a file à la: ja_JP.md (Japanese_Japan) or it_CH.md (Italian_Switzerland), in which you briefly describe what the current status of your translation effort is and what has been translated and which parts might be gotchas.
This would also be a good place to quickly explain what your language is about, like whether most technical terms are a translation from the original, an adaptation from the English word or perhaps you just mostly use English terms.

## Style

Please follow whatever is the purest and most intelligible form of written language in the native tongue being translated.

## Formatting

It is important to use correct formatting. This is wrong:

```
<p><?php echo __('Are you sure you want to delete Proposal #') . $id . '?' ?></p>
```

You want to have ultimate flexibility and that line should look more like this:

```
<p><?php echo __('Are you sure you want to delete Proposal #{id}?');?></p>
```

In the above example we use an alternative notation of the format string in PHP. Using the above, the generated po-template file ([default.pot](https://github.com/MISP/MISP/blob/2.4/app/Locale/default.pot)) will have the name of the to-be-translated variable in the "msgid" part of the file. Which is easier to read then a non descriptive %s and allows the translator to have context on how the phrase is used in MISP.

In case you have HTML-Tags, move them out of the sentence:
```
<p><?php echo __('<h1>Are you sure you want to delete Proposal #%s?', $id);?></h1></p>
```

```
<p><?php echo __('%sAre you sure you want to delete Proposal #{id}?', '<h1>');?></h1></p>
```



## Issues

Some times it might be impossible to translate some phrases.
Or you notice a certain bad formatting, or segmentation of sentences.
In that case, please either open an [Issue on Github](https://github.com/MISP/MISP/issues)

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

Are you planning to do a translation or localization? Please open a ticket on the [issue system](https://github.com/MISP/MISP-book/issues). This will allow us and others to track what is being worked on. You can keep it very light, as all the details should be in your markdown in misp-book.

## Reach out to the community

Want to chat with other MISP contributors? Make sure to join our [MISP Gitter channel](https://gitter.im/MISP/MISP).
