package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.handler.AvatarInfoWidgetHandler;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenProfileMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.room.object.IRoomObject;
   
   public class PetMenuView extends AvatarContextInfoButtonView
   {
      
      protected static const MODE_NORMAL:uint = 0;
      
      private static const MODE_SADDLED_UP:int = 1;
      
      private static const MODE_RIDING:int = 2;
      
      private static const MODE_MONSTER_PLANT:int = 3;
      
      private var var_24:PetInfoData;
      
      private var var_261:int = 0;
      
      public function PetMenuView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_236 = false;
      }
      
      public static function setup(param1:PetMenuView, param2:int, param3:String, param4:int, param5:int, param6:PetInfoData) : void
      {
         param1.var_24 = param6;
         var _loc7_:Boolean = param1.widget.hasFreeSaddle;
         var _loc8_:Boolean = param1.widget.isRiding;
         if(param1.widget.isMonsterPlant())
         {
            param1.var_261 = 3;
         }
         else if(_loc7_ && !_loc8_)
         {
            param1.var_261 = 1;
         }
         else if(_loc8_)
         {
            param1.var_261 = 2;
         }
         else
         {
            param1.var_261 = 0;
         }
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         var_24 = null;
         super.dispose();
      }
      
      protected function updateButtons() : void
      {
         var _loc8_:int = 0;
         var _loc1_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:AvatarInfoWidgetHandler = null;
         var _loc3_:int = 0;
         var _loc11_:IRoomObject = null;
         var _loc5_:int = 0;
         if(!_window || !var_24)
         {
            return;
         }
         var _loc4_:IItemListWindow = _window.findChildByName("buttons") as IItemListWindow;
         if(!_loc4_)
         {
            return;
         }
         _loc4_.procedure = buttonEventProc;
         _loc4_.autoArrangeItems = false;
         var _loc7_:int = _loc4_.numListItems;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc4_.getListItemAt(_loc8_).visible = false;
            _loc8_++;
         }
         var _loc10_:IRoomSession = widget.handler.roomSession;
         var _loc6_:ISessionDataManager = widget.handler.container.sessionDataManager;
         if(_loc10_.isRoomOwner || _loc6_.isAnyRoomController || _loc10_.roomControllerLevel >= 1)
         {
            showButton("pick_up");
         }
         switch(var_261)
         {
            case 0:
               showButton("respect",var_24.petRespectLeft > 0);
               break;
            case 1:
               if(widget.configuration.getBoolean("sharedhorseriding.enabled"))
               {
                  showButton("mount");
               }
               showButton("respect",var_24.petRespectLeft > 0);
               break;
            case 2:
               if(widget.configuration.getBoolean("sharedhorseriding.enabled"))
               {
                  showButton("dismount");
               }
               showButton("respect",var_24.petRespectLeft > 0);
               break;
            case 3:
               if(!var_24.canRevive)
               {
                  showButton("respect",false);
                  _loc1_ = var_24.energy as Number;
                  _loc9_ = var_24.energyMax as Number;
                  showButton("treat",true,_loc1_ / _loc9_ < 0.98);
               }
         }
         widget.localizations.registerParameter("infostand.button.petrespect","count",var_24.petRespectLeft.toString());
         if(widget.configuration.getBoolean("handitem.give.pet.enabled"))
         {
            _loc2_ = widget.handler;
            _loc3_ = _loc2_.container.roomSession.ownUserRoomId;
            _loc11_ = _loc2_.container.roomEngine.getRoomObject(_loc2_.roomSession.roomId,_loc3_,100);
            if(_loc11_ != null)
            {
               _loc5_ = _loc11_.getModel().getNumber("figure_carry_object");
               if(_loc5_ > 0 && _loc5_ < 999999)
               {
                  showButton("pass_handitem");
               }
            }
         }
         showButton("wired_inspect",widget.handler.container.userDefinedRoomEvents.showInspectButton());
         _loc4_.autoArrangeItems = true;
         _loc4_.visible = true;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("pet_menu")).content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(!_window)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               _window.findChildByName("minimize").addEventListener("WME_CLICK",onMinimize);
               _window.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
               _window.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            }
            var_34 = _window.findChildByName("buttons") as IItemListWindow;
            var_34.procedure = buttonEventProc;
            _window.findChildByName("name").caption = _userName;
            _window.visible = false;
            activeView = _window;
            updateButtons();
         }
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         var _loc4_:RoomWidgetMessage = null;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               switch(param2.parent.name)
               {
                  case "mount":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_MOUNT_PET",userId);
                     break;
                  case "dismount":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_DISMOUNT_PET",userId);
                     break;
                  case "respect":
                     var_24.petRespectLeft -= 1;
                     updateButtons();
                     _loc4_ = new RoomWidgetUserActionMessage(" RWUAM_RESPECT_PET",userId);
                     break;
                  case "treat":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_TREAT_PET",userId);
                     break;
                  case "pass_handitem":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_GIVE_CARRY_ITEM_TO_PET",userId);
                     break;
                  case "pick_up":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_PICKUP_PET",userId);
                     break;
                  case "wired_inspect":
                     _loc4_ = new RoomWidgetUserActionMessage("RWUAM_WIRED_INSPECT_PET",userId);
               }
            }
            if(param2.name == "profile_link")
            {
               _loc4_ = new RoomWidgetOpenProfileMessage("RWOPEM_OPEN_USER_PROFILE",var_1270,"petContextMenu");
            }
            if(_loc4_ != null)
            {
               var_16.messageListener.processWidgetMessage(_loc4_);
            }
            updateButtons();
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            var_16.removeView(this,false);
         }
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
   }
}

