#!/bin/bash

MAC_TELEKASTEN="/tmp/reminders_Telekasten.txt"
VAULT="/Users/lucas/zettelkasten"
DELIM="zettelkasten"

if ! command -v reminders &> /dev/null
then
    echo "Please install 'reminders' from https://github.com/keith/reminders-cli"
    exit
fi

if ! reminders show-lists |grep -q "Telekasten"; then
  echo "Please create 'Telekasten' list in Mac Reminders manually."
  exit
fi

reminders show Telekasten > $MAC_TELEKASTEN

rg -N -e "^- \[[ ]\]" $VAULT|sed 's/- \[[ x]\] //g' | while read -r line; 
do 
  list=`echo $line | awk -F'.md:' '{print $1}' | awk -F"$DELIM\/" '{print $NF}'`
  item=`echo $line | awk -F'.md:' '{print $2}'`
  item=`echo $item | sed 's/\[/【/g'|sed 's/\]/】/g'`
  if ! grep -q "^[0-9]*: $list:$item$" $MAC_TELEKASTEN; then
    reminders add Telekasten "$list:$item"
  fi
done


rg -N -e "^- \[x\]" $VAULT/|sed 's/- \[[ x]\] //g' | while read -r line; 
do 
  list=`echo $line | awk -F'.md:' '{print $1}' | awk -F"$DELIM\/" '{print $NF}'`
  item=`echo $line | awk -F'.md:' '{print $2}'`
  item=`echo $item | sed 's/\[/【/g'|sed 's/\]/】/g'`
  grep "^[0-9]*: $list:$item$" $MAC_TELEKASTEN | while read -r mac_line;
  do
    ID=`echo $mac_line | cut -d: -f1`
    reminders complete Telekasten $ID
  done
done



cat $MAC_TELEKASTEN |sed 's/^[0-9]*: //' | while read -r line; 
do
  list=`echo $line | sed 's/:.*//'`
  item=`echo $line | sed 's/^[^:]*://'`
  item=`echo $item | sed 's/【/\[/g'|sed 's/】/\]/g'`
  md=$VAULT/$list.md
  blank_patterned_item=`echo $item | sed 's/ / \*/g' |sed 's/\[/\\\[/g'|sed 's/\]/\\\]/g' `
  if ! grep -q "\- \[ \] $blank_patterned_item" "$md"; then
    echo "Add $item to $list.md"
    echo "- [ ] $item" >> $md
  fi
done


