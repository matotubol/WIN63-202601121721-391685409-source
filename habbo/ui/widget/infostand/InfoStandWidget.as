package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.InfoStandWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFurniInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetCommandsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetFigureUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPetInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectPlaceEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceRoomItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.catalog.BuildersClubPlaceWallItemMessageComposer;
   
   public class InfoStandWidget extends RoomWidgetBase
   {
      
      private static const PLACEMENT_PAGE_ID:int = -1;
      
      private const USER_VIEW:String = "infostand_user_view";
      
      private const const_529:String = "infostand_furni_view";
      
      private const PET_VIEW:String = "infostand_pet_view";
      
      private const BOT_VIEW:String = "infostand_bot_view";
      
      private const RENTABLE_BOT_VIEW:String = "infostand_rentable_bot_view";
      
      private const const_292:String = "infostand_jukebox_view";
      
      private const CRACKABLE_FURNI_VIEW:String = "infostand_crackable_furni_view";
      
      private const SONGDISK_VIEW:String = "infostand_songdisk_view";
      
      private var var_1750:InfoStandFurniView;
      
      private var var_284:InfoStandUserView;
      
      private var var_423:InfoStandPetView;
      
      private var var_682:InfoStandBotView;
      
      private var var_1051:InfoStandRentableBotView;
      
      private var var_1743:InfoStandJukeboxView;
      
      private var var_1788:InfoStandCrackableFurniView;
      
      private var var_1689:InfoStandSongDiskView;
      
      private var var_5394:Array;
      
      private var var_2470:InfoStandUserData;
      
      private var var_85:InfoStandFurniData;
      
      private var var_311:InfoStandPetData;
      
      private var var_3678:InfoStandRentableBotData;
      
      private var var_39:class_1812;
      
      private var var_251:Timer;
      
      private var _config:class_16;
      
      private const UPDATE_INTERVAL_MS:int = 3000;
      
      public function InfoStandWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_16, param6:IHabboCatalog)
      {
         super(param1,param2,param3,param4);
         _config = param5;
         var_1750 = new InfoStandFurniView(this,"infostand_furni_view",param6);
         var_284 = new InfoStandUserView(this,"infostand_user_view");
         var_423 = new InfoStandPetView(this,"infostand_pet_view",param6);
         var_682 = new InfoStandBotView(this,"infostand_bot_view");
         var_1051 = new InfoStandRentableBotView(this,"infostand_rentable_bot_view",param6);
         var_1743 = new InfoStandJukeboxView(this,"infostand_jukebox_view",param6);
         var_1788 = new InfoStandCrackableFurniView(this,"infostand_crackable_furni_view",param6);
         var_1689 = new InfoStandSongDiskView(this,"infostand_songdisk_view",param6);
         var_2470 = new InfoStandUserData();
         var_85 = new InfoStandFurniData();
         var_311 = new InfoStandPetData();
         var_3678 = new InfoStandRentableBotData();
         var_251 = new Timer(3000);
         var_251.addEventListener("timer",onUpdateTimer);
         mainContainer.visible = false;
         this.handler.widget = this;
      }
      
      public function get handler() : InfoStandWidgetHandler
      {
         return var_41 as InfoStandWidgetHandler;
      }
      
      public function get furniView() : InfoStandFurniView
      {
         return var_1750;
      }
      
      override public function get mainWindow() : class_1741
      {
         return mainContainer;
      }
      
      public function get config() : class_16
      {
         return _config;
      }
      
      public function get mainContainer() : class_1812
      {
         if(var_39 == null)
         {
            var_39 = windowManager.createWindow("infostand_main_container","",4,0,0,new Rectangle(0,0,50,100)) as class_1812;
            var_39.tags.push("room_widget_infostand");
            var_39.background = true;
            var_39.color = 0;
         }
         return var_39;
      }
      
      public function favouriteGroupUpdated(param1:int, param2:int, param3:int, param4:String) : void
      {
         if(!userData || userData.userRoomId != param1)
         {
            return;
         }
         if(!mainContainer)
         {
            return;
         }
         var _loc5_:class_1741 = mainContainer.findChildByName("infostand_user_view");
         if(!_loc5_ || !_loc5_.visible)
         {
            return;
         }
         var_284.clearGroupBadge();
         if(param2 != -1)
         {
            var _loc6_:String = handler.container.sessionDataManager.getGroupBadgeId(param2);
            userData.groupId = param2;
            userData.groupBadgeId = null;
            userData.groupName = param4;
            var_284.setGroupBadge(null);
         }
      }
      
      public function getXmlWindow(param1:String) : class_1741
      {
         var _loc4_:IAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:class_1741 = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
            class_21.log("[InfoStandWidget] Missing window XML: " + param1);
         }
         return _loc3_;
      }
      
      public function setRelationshipStatus(param1:int, param2:class_55) : void
      {
         if(var_2470.userId == param1)
         {
            var_284.setRelationshipStatuses(param2);
         }
      }
      
      override public function dispose() : void
      {
         if(var_251)
         {
            var_251.stop();
         }
         var_251 = null;
         if(var_284)
         {
            var_284.dispose();
         }
         var_284 = null;
         if(var_1750)
         {
            var_1750.dispose();
         }
         var_1750 = null;
         if(var_682)
         {
            var_682.dispose();
         }
         var_682 = null;
         if(var_1051)
         {
            var_1051.dispose();
         }
         var_1051 = null;
         if(var_423)
         {
            var_423.dispose();
         }
         var_423 = null;
         if(var_1743)
         {
            var_1743.dispose();
         }
         var_1743 = null;
         if(var_1788)
         {
            var_1788.dispose();
         }
         var_1788 = null;
         if(var_1689)
         {
            var_1689.dispose();
         }
         var_1689 = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWROUE_OBJECT_SELECTED",onRoomObjectSelected);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onClose);
         param1.addEventListener("RWROUE_USER_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWROUE_OBJECT_PLACED",onRoomObjectPlaced);
         param1.addEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.addEventListener("RWUIUE_PEER",onUserInfo);
         param1.addEventListener("RWUIUE_BOT",onBotInfo);
         param1.addEventListener("RWFIUE_FURNI",onFurniInfo);
         param1.addEventListener("RWRBIUE_RENTABLE_BOT",onRentableBotInfo);
         param1.addEventListener("RWPIUE_PET_INFO",onPetInfo);
         param1.addEventListener("RWPCUE_PET_COMMANDS",onPetCommands);
         param1.addEventListener("RWPCUE_OPEN_PET_TRAINING",onOpenPetTraining);
         param1.addEventListener("RWPCUE_CLOSE_PET_TRAINING",onClosePetTraining);
         param1.addEventListener("RWSUE_PLAYING_CHANGED",onSongUpdate);
         param1.addEventListener("RWSUE_DATA_RECEIVED",onSongUpdate);
         param1.addEventListener("RWPIUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWROUE_OBJECT_SELECTED",onRoomObjectSelected);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onClose);
         param1.removeEventListener("RWROUE_USER_REMOVED",onRoomObjectRemoved);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.removeEventListener("RWROUE_OBJECT_PLACED",onRoomObjectPlaced);
         param1.removeEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.removeEventListener("RWUIUE_PEER",onUserInfo);
         param1.removeEventListener("RWUIUE_BOT",onBotInfo);
         param1.removeEventListener("RWFIUE_FURNI",onFurniInfo);
         param1.removeEventListener("RWPIUE_PET_INFO",onPetInfo);
         param1.removeEventListener("RWPCUE_PET_COMMANDS",onPetCommands);
         param1.removeEventListener("RWPCUE_OPEN_PET_TRAINING",onOpenPetTraining);
         param1.removeEventListener("RWPCUE_CLOSE_PET_TRAINING",onClosePetTraining);
         param1.removeEventListener("RWSUE_PLAYING_CHANGED",onSongUpdate);
         param1.removeEventListener("RWSUE_DATA_RECEIVED",onSongUpdate);
         param1.removeEventListener("RWPIUE_PET_FIGURE_UPDATE",onPetFigureUpdate);
      }
      
      public function get rentableBotData() : InfoStandRentableBotData
      {
         return var_3678;
      }
      
      public function get userData() : InfoStandUserData
      {
         return var_2470;
      }
      
      public function get furniData() : InfoStandFurniData
      {
         return var_85;
      }
      
      public function get petData() : InfoStandPetData
      {
         return var_311;
      }
      
      private function onUpdateTimer(param1:TimerEvent) : void
      {
         if(var_423 == null)
         {
            return;
         }
         messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_REQUEST_PET_UPDATE",var_423.getCurrentPetId()));
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         if(handler.container.sessionDataManager.isBlocked(param1.webID))
         {
            return;
         }
         var_284.update(param1);
         selectView("infostand_user_view");
         if(var_251)
         {
            var_251.stop();
         }
      }
      
      private function onBotInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         userData.setData(param1);
         var_682.update(param1);
         selectView("infostand_bot_view");
         if(var_251)
         {
            var_251.stop();
         }
      }
      
      private function onRentableBotInfo(param1:RoomWidgetRentableBotInfoUpdateEvent) : void
      {
         rentableBotData.setData(param1);
         var_1051.update(param1);
         selectView("infostand_rentable_bot_view");
         if(var_251)
         {
            var_251.stop();
         }
      }
      
      private function onFurniInfo(param1:RoomWidgetFurniInfoUpdateEvent) : void
      {
         furniData.setData(param1);
         if(param1.extraParam == "RWEIEP_JUKEBOX")
         {
            var_1743.update(param1);
            selectView("infostand_jukebox_view");
         }
         else if(param1.extraParam.indexOf("RWEIEP_SONGDISK") != -1)
         {
            var_1689.update(param1);
            selectView("infostand_songdisk_view");
         }
         else if(param1.extraParam.indexOf("RWEIEP_CRACKABLE_FURNI") != -1)
         {
            var_1788.update(param1);
            selectView("infostand_crackable_furni_view");
         }
         else
         {
            var_1750.update(param1);
            selectView("infostand_furni_view");
         }
         if(var_251)
         {
            var_251.stop();
         }
      }
      
      private function onPetInfo(param1:RoomWidgetPetInfoUpdateEvent) : void
      {
         petData.setData(param1);
         userData.petRespectLeft = param1.petRespectLeft;
         var_423.update(petData);
         selectView("infostand_pet_view");
         if(var_251)
         {
            var_251.start();
         }
      }
      
      private function onPetFigureUpdate(param1:RoomWidgetPetFigureUpdateEvent) : void
      {
         var_423.updateImage(param1.petId,param1.image);
      }
      
      private function onPetCommands(param1:RoomWidgetPetCommandsUpdateEvent) : void
      {
         var _loc2_:Array = param1.allCommands;
         var _loc3_:Array = param1.enabledCommands;
         if(petData.type == 0 && !_config.getBoolean("nest.breeding.dog.enabled") || petData.type == 1 && !_config.getBoolean("nest.breeding.cat.enabled") || petData.type == 5 && !_config.getBoolean("nest.breeding.pig.enabled"))
         {
            if(_loc2_.indexOf(46) != -1)
            {
               _loc2_.splice(_loc2_.indexOf(46),1);
            }
            if(_loc3_.indexOf(46) != -1)
            {
               _loc3_.splice(_loc3_.indexOf(46),1);
            }
         }
         var_423.updateEnabledTrainingCommands(param1.id,new CommandConfiguration(param1.allCommands,param1.enabledCommands));
      }
      
      private function onOpenPetTraining(param1:RoomWidgetUpdateEvent) : void
      {
         var_423.openTrainView();
      }
      
      private function onClosePetTraining(param1:RoomWidgetUpdateEvent) : void
      {
         var_423.closeTrainView();
      }
      
      public function updateUserData(param1:int, param2:String, param3:int, param4:String, param5:Boolean) : void
      {
         if(param1 != userData.userId)
         {
            return;
         }
         if(userData.isBot())
         {
            var_682.setFigure(param2);
         }
         else
         {
            var_284.setFigure(param2);
            var_284.setMotto(param4,param5);
            if(handler.isActivityDisplayEnabled)
            {
               var_284.achievementScore = param3;
            }
         }
      }
      
      public function refreshBadges(param1:int, param2:Array) : void
      {
         if(param1 != userData.userId)
         {
            return;
         }
         userData.badges = param2;
         if(userData.isBot())
         {
            var_682.clearBadges();
         }
         else
         {
            var_284.clearBadges();
         }
         for each(var _loc3_ in param2)
         {
            refreshBadge(_loc3_);
         }
      }
      
      public function refreshBadge(param1:String) : void
      {
         var _loc2_:int = int(userData.badges.indexOf(param1));
         if(_loc2_ >= 0)
         {
            if(userData.isBot())
            {
               var_682.setBadge(_loc2_,param1);
            }
            else
            {
               var_284.setBadge(_loc2_,param1);
            }
            return;
         }
         if(param1 == userData.groupBadgeId)
         {
            var_284.setGroupBadge(param1);
         }
      }
      
      private function onRoomObjectPlaced(param1:RoomWidgetRoomObjectPlaceEvent) : void
      {
         if(param1.placementSource == "info_stand")
         {
            if(!param1.placedInRoom)
            {
               return;
            }
            switch(param1.category - 10)
            {
               case 0:
                  if(!param1.placedOnFloor)
                  {
                     return;
                  }
                  handler.container.connection.send(new BuildersClubPlaceRoomItemMessageComposer(-1,furniData.bcOfferId,furniData.extraParam,param1.x,param1.y,param1.direction));
                  break;
               case 10:
                  if(!param1.placedOnWall)
                  {
                     return;
                  }
                  handler.container.connection.send(new BuildersClubPlaceWallItemMessageComposer(-1,furniData.bcOfferId,furniData.extraParam,param1.wallLocation));
            }
            requestItemToMover();
         }
      }
      
      public function requestItemToMover() : void
      {
         var _loc1_:IRoomEngine = handler.container.roomEngine;
         _loc1_.initializeRoomObjectInsert("info_stand",-furniData.bcOfferId,furniData.category,furniData.classId,furniData.extraParam,null,-1,-1,null,true);
      }
      
      private function onRoomObjectSelected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage("RWROM_GET_OBJECT_INFO",param1.id,param1.category);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         var _loc2_:* = false;
         switch(param1.type)
         {
            case "RWROUE_FURNI_REMOVED":
               _loc2_ = param1.id == var_85.id;
               break;
            case "RWROUE_USER_REMOVED":
               if(var_284 != null && var_284.window != null && Boolean(var_284.window.visible))
               {
                  _loc2_ = param1.id == var_2470.userRoomId;
                  break;
               }
               if(var_423 != null && var_423.window != null && Boolean(var_423.window.visible))
               {
                  _loc2_ = param1.id == var_311.roomIndex;
                  break;
               }
               if(var_682 != null && var_682.window != null && Boolean(var_682.window.visible))
               {
                  _loc2_ = param1.id == var_2470.userRoomId;
                  break;
               }
               if(var_1051 != null && var_1051.window != null && Boolean(var_1051.window.visible))
               {
                  _loc2_ = param1.id == var_3678.userRoomId;
               }
         }
         if(_loc2_)
         {
            close();
         }
      }
      
      private function onSongUpdate(param1:RoomWidgetSongUpdateEvent) : void
      {
         var_1743.updateSongInfo(param1);
         var_1689.updateSongInfo(param1);
      }
      
      public function close() : void
      {
         hideChildren();
         if(var_251)
         {
            var_251.stop();
         }
      }
      
      private function onClose(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         close();
         if(var_251)
         {
            var_251.stop();
         }
      }
      
      private function hideChildren() : void
      {
         var _loc1_:int = 0;
         if(var_39 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_39.numChildren)
            {
               var_39.getChildAt(_loc1_).visible = false;
               _loc1_++;
            }
         }
      }
      
      public function isFurniViewVisible() : Boolean
      {
         var _loc1_:class_1741 = null;
         if(var_39 != null)
         {
            _loc1_ = var_39.getChildByName("infostand_furni_view") as class_1741;
            if(_loc1_ != null)
            {
               return _loc1_.visible;
            }
         }
         return false;
      }
      
      private function selectView(param1:String) : void
      {
         hideChildren();
         var _loc2_:class_1741 = mainContainer.getChildByName(param1) as class_1741;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         mainContainer.visible = true;
         mainContainer.width = _loc2_.width;
         mainContainer.height = _loc2_.height;
      }
      
      public function refreshContainer() : void
      {
         var _loc2_:class_1741 = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < mainContainer.numChildren)
         {
            _loc2_ = mainContainer.getChildAt(_loc1_);
            if(_loc2_.visible)
            {
               mainContainer.width = _loc2_.width;
               mainContainer.height = _loc2_.height;
            }
            _loc1_++;
         }
      }
      
      override public function release() : void
      {
         close();
         super.release();
      }
   }
}

