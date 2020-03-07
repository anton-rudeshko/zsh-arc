# zsh-arc

> zsh plugin with aliases for Yandex version control system `arc`

https://habr.com/ru/company/yandex/blog/482926/

## Installation

### [Antigen]

[Antigen]: https://github.com/zsh-users/antigen

```
antigen bundle anton-rudeshko/zsh-arc
```

Or add to your `.antigenrc`:

```
antigen bundles <<EOBUNDLES
    …
    anton-rudeshko/zsh-arc
    …
EOBUNDLES
```

## Usage

Keep in mind that there are utilities shadowed with aliases:

```console
$ which -a $(alias | grep -oE "^a[^=]*") | grep -v arc
a: aliased to fasd -a
/usr/sbin/ab
/usr/sbin/ac
afind: aliased to ack -il
/usr/sbin/amt
```

Run shadowed commands via `command cmd` or `\cmd`.

## Development

```
/Users/rudeshko/dev/zsh-arc --no-local-clone
```

It is necessary to use absolute path.
