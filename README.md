# synctodo

Sync todos among Telekasten, Mac Reminders and iPhone Reminders

I use Macbook pro and iPhone, normally the todos in Reminders are synced between Mac/iPhone by iCloud.

However, I also create todos in Telekasten notes, such like take some notes while programming, think of something need to do, then I create todo in Telekasten notes directly. When I walk away from Macbook, I'd like to check todos on iPhone. or, maybe just have something to remember before sleeping, make one reminder in iPhone Reminders, then tomorrow morning when I come back to office, I could see it in Telekasten.

I wrote this script to sync todos between Telekasten and Mac Reminders bidirectionally.
so I am able to manage/check todos anywhere with MacBook or iPhone.

# Pre-requisites:

Install reminder-cli from

https://github.com/keith/reminders-cli"

Create "Telekasten" list in Mac Reminders application

# Usage

```
synctoo.sh
```

## Sync from Telekasten to Reminders

1. `- [ ] something` will be synced to Reminders as a new item.
2. when changed to `- [x] somehing`, it will be marked as done in Reminders

## Sync from Reminders to Telekasten

Only todos in "Telekasten" list are synced.

newly createed todos will be synced to Telekasten

1. `topic:abcd` will be put into "topic.md" as `- [ ] abcd`
2. `abcd` (without list name) will be put into "Reminders.md" as `- [ ] abcd`

Attention: the first ':' of a Reminders item will always be used as separator between TK note name and todo text. so normally, you'd like to avoid have ':' in todo text
