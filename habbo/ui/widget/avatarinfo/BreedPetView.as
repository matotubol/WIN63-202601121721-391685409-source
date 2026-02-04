package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.events.UseProductItem;
   
   public class BreedPetView extends AvatarContextInfoButtonView
   {
      
      private static const MODE_NORMAL:int = 0;
      
      private var var_261:int;
      
      private var var_644:UseProductItem;
      
      private var var_3982:Boolean;
      
      public function BreedPetView(param1:AvatarInfoWidget)
      {
         super(param1);
         var_236 = false;
      }
      
      public static function setup(param1:BreedPetView, param2:int, param3:String, param4:int, param5:int, param6:UseProductItem, param7:Boolean) : void
      {
         param1.var_644 = param6;
         param1.var_3982 = param7;
         AvatarContextInfoButtonView.setup(param1,param2,param3,param4,param5,false);
      }
      
      public function get objectId() : int
      {
         return var_644.id;
      }
      
      public function get requestRoomObjectId() : int
      {
         return var_644.requestRoomObjectId;
      }
      
      override public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_OVER",onMouseHoverEvent);
            _window.removeEventListener("WME_OUT",onMouseHoverEvent);
         }
         if(var_644)
         {
            var_644.dispose();
         }
         var_644 = null;
         super.dispose();
      }
      
      private function resolveMode() : void
      {
         var _loc1_:int = widget.handler.roomSession.roomId;
         var_261 = 0;
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         resolveMode();
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(!_window)
            {
               _loc1_ = XmlAsset(var_16.assets.getAssetByName("breed_pet_menu")).content as XML;
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
      
      public function updateButtons() : void
      {
         var _loc2_:int = 0;
         if(!_window || !var_34)
         {
            return;
         }
         var_34.autoArrangeItems = false;
         var _loc1_:int = var_34.numListItems;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            var_34.getListItemAt(_loc2_).visible = false;
            _loc2_++;
         }
         switch(var_261)
         {
            case 0:
               if(var_3982)
               {
                  showButton("breed");
               }
         }
         var_34.autoArrangeItems = true;
         var_34.visible = true;
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
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               _loc3_ = true;
               var _loc5_:* = param2.parent.name;
               if("breed" === _loc5_)
               {
                  widget.showBreedMonsterPlantsConfirmationView(var_644.requestRoomObjectId,var_644.targetRoomObjectId,false);
               }
            }
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
         if(_loc3_)
         {
            widget.removeBreedPetViews();
         }
      }
      
      private function changeMode(param1:int) : void
      {
         var_261 = param1;
         updateButtons();
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
   }
}

