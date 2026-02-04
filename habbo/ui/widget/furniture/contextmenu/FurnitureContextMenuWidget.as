package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.groups.class_140;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.handler.FurnitureContextMenuWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.contextmenu.ContextInfoView;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import com.sulake.habbo.ui.widget.furniture.effectbox.EffectBoxOpenDialogView;
   import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.guildfurnicontextmenu.GuildFurnitureContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxContextMenuView;
   import com.sulake.habbo.ui.widget.furniture.mysterybox.MysteryBoxOpenDialogView;
   import com.sulake.habbo.ui.widget.furniture.mysterytrophy.MysteryTrophyOpenDialogView;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   
   public class FurnitureContextMenuWidget extends RoomWidgetBase implements class_1853, class_31
   {
      
      private var var_59:class_17;
      
      private var var_18:FurnitureContextInfoView;
      
      private var _selectedObject:IRoomObject = null;
      
      private var var_1121:GuildFurnitureContextMenuView;
      
      private var var_2095:RandomTeleportContextMenuView;
      
      private var var_1876:MonsterPlantSeedContextMenuView;
      
      private var var_1038:MonsterPlantSeedConfirmationView;
      
      private var var_1297:EffectBoxOpenDialogView;
      
      private var var_1043:MysteryBoxContextMenuView;
      
      private var var_1385:MysteryTrophyOpenDialogView;
      
      private var var_2522:MysteryBoxOpenDialogView;
      
      private var var_1156:FriendFurniContextMenuView;
      
      private var var_1021:GenericUsableFurnitureContextMenuView;
      
      private var _catalog:IHabboCatalog;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1274:PurchasableClothingConfirmationView;
      
      public function FurnitureContextMenuWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_16, param5:class_27, param6:class_17, param7:class_140, param8:IHabboCatalog)
      {
         super(param1,param2,param3,param5);
         var_59 = param6;
         var_1121 = new GuildFurnitureContextMenuView(this,param7,param2);
         var_2095 = new RandomTeleportContextMenuView(this);
         var_1876 = new MonsterPlantSeedContextMenuView(this);
         var_1043 = new MysteryBoxContextMenuView(this);
         var_1156 = new FriendFurniContextMenuView(this);
         var_1021 = new GenericUsableFurnitureContextMenuView(this);
         var_1038 = new MonsterPlantSeedConfirmationView(this);
         var_2522 = new MysteryBoxOpenDialogView(this);
         var_1297 = new EffectBoxOpenDialogView(this);
         var_1385 = new MysteryTrophyOpenDialogView(this);
         var_1274 = new PurchasableClothingConfirmationView(this);
         _catalog = param8;
         this.handler.widget = this;
         this.handler.roomEngine.events.addEventListener("REOE_REMOVED",onRoomObjectRemoved);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_59.removeUpdateReceiver(this);
         removeView(var_18,false);
         var_1121.dispose();
         var_1121 = null;
         var_2095.dispose();
         var_2095 = null;
         var_1876.dispose();
         var_1876 = null;
         var_1038.dispose();
         var_1038 = null;
         var_1043.dispose();
         var_1043 = null;
         var_2522.dispose();
         var_2522 = null;
         var_1156.dispose();
         var_1156 = null;
         var_1021.dispose();
         var_1021 = null;
         var_1297.dispose();
         var_1297 = null;
         var_1385.dispose();
         var_1385 = null;
         var_1274.dispose();
         var_1274 = null;
         _catalog = null;
         super.dispose();
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function get handler() : FurnitureContextMenuWidgetHandler
      {
         return var_41 as FurnitureContextMenuWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _container ? _container.roomEngine : null;
      }
      
      public function hideContextMenu(param1:IRoomObject) : void
      {
         if(_selectedObject != null && _selectedObject.getId() == param1.getId())
         {
            removeView(var_18,false);
            var_59.removeUpdateReceiver(this);
            _selectedObject = null;
         }
      }
      
      public function showGuildFurnitureContextMenu(param1:IRoomObject, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean) : void
      {
         _selectedObject = param1;
         var_1121.var_3004 = param2;
         var_1121.var_2816 = param4;
         var_1121.var_3215 = param5;
         var_1121.var_2695 = param6;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         var_18 = var_1121;
         FurnitureContextInfoView.setup(var_18,param1,param3);
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function showRandomTeleportContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         var_2095.objectCategory = param2;
         var_18 = var_2095;
         FurnitureContextInfoView.setup(var_18,param1);
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function showMonsterPlantSeedContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         var_1876.objectCategory = param2;
         var_18 = var_1876;
         FurnitureContextInfoView.setup(var_18,param1);
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function showPlantSeedConfirmationDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(!var_1038)
         {
            var_1038 = new MonsterPlantSeedConfirmationView(this);
         }
         var_1038.open(param1.getId());
      }
      
      public function showPurchasableClothingConfirmationDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(!var_1274)
         {
            var_1274 = new PurchasableClothingConfirmationView(this);
         }
         var_1274.open(param1.getId());
      }
      
      public function showEffectBoxOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(!var_1297)
         {
            var_1297 = new EffectBoxOpenDialogView(this);
         }
         var_1297.open(param1.getId());
      }
      
      public function showMysteryTrophyOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(!var_1385)
         {
            var_1385 = new MysteryTrophyOpenDialogView(this);
         }
         var_1385.open(param1.getId());
      }
      
      private function removePlantSeedConfirmationView() : void
      {
         if(var_1038 != null)
         {
            var_1038.close();
         }
      }
      
      public function showMysteryBoxContextMenu(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(var_1043 == null)
         {
            var_1043 = new MysteryBoxContextMenuView(this);
         }
         var_1043.isOwnerMode = handler.container.isOwnerOfFurniture(param1);
         var_1043.show();
         var_18 = var_1043;
         FurnitureContextInfoView.setup(var_18,param1);
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function showFriendFurnitureContextMenu(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(var_1156 == null)
         {
            var_1156 = new FriendFurniContextMenuView(this);
         }
         var_1156.show();
         var_18 = var_1156;
         FurnitureContextInfoView.setup(var_18,param1);
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function showUsableFurnitureContextMenu(param1:IRoomObject, param2:int) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         if(var_1021 == null)
         {
            var_1021 = new GenericUsableFurnitureContextMenuView(this);
         }
         var_1021.show();
         var_1021.objectCategory = param2;
         var_18 = var_1021;
         FurnitureContextInfoView.setup(var_18,param1);
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function showMysteryBoxOpenDialog(param1:IRoomObject) : void
      {
         _selectedObject = param1;
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         var_2522.startOpenFlow(param1);
      }
      
      public function removeView(param1:ContextInfoView, param2:Boolean) : void
      {
         if(param1)
         {
            param1.hide(false);
            if(param1 == var_18)
            {
               var_18 = null;
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         if(var_18 && _selectedObject)
         {
            var_18.update(this.handler.getObjectRectangle(_selectedObject.getId()),this.handler.getObjectScreenLocation(_selectedObject.getId()),param1);
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      private function onRoomObjectRemoved(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = 0;
         if(param1.category == 10)
         {
            _loc2_ = param1.objectId;
            if(_selectedObject != null && _selectedObject.getId() == _loc2_)
            {
               removeView(var_18,false);
               removePlantSeedConfirmationView();
               var_59.removeUpdateReceiver(this);
               _selectedObject = null;
            }
         }
      }
      
      public function get friendList() : class_258
      {
         return null;
      }
      
      override public function release() : void
      {
         if(_selectedObject != null)
         {
            hideContextMenu(_selectedObject);
         }
         if(var_18 != null)
         {
            removeView(var_18,false);
         }
         super.release();
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
      }
   }
}

