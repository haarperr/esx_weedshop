# ESX WEEDSHOP
Author: Dividerz -> https://forum.cfx.re/u/dividerz/summary
Discord for support: Arne#7777

**DEPENDENCIES**

- es_extended
- progressBars
- MLO used in this resource: https://www.gta5-mods.com/maps/mlo-legion-weed-clinic

**HOW IT WORKS**

'Job' works through a storage system. Players can sell their weed at the coffeeshop for some quick cash, this weed will eventually be added into the storage of the shop. With weed, you're able to roll joints as a shop employee. Joints get selled at the register, which also has an amount of cash money inside it. 

**INSTALLATION**

Import the .sql file in your database. Drag and drop the resource in your ESX folder and start it by using ```ensure esx_weedshop``` in your server.cfg file.

**CONFIGURATION**

`Config.WeedItem = "weed"` -> the item name of weed in your server, mostly just 'weed'.

`Config.WeedPrice = 3` -> price per weed, equals to amount player has times 3.

`Config.JointPrice = 20` -> price for one joint.

`Config.JobName = "weedshop"` -> don't change this unless you already have a job set up in your server.

`Config.ShopName = "Coffeeshop The Bulldog"` -> name of the shop, used as blipname.

