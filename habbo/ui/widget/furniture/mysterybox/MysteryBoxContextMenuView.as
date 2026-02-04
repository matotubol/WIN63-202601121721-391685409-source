package com.sulake.habbo.ui.widget.furniture.mysterybox
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.ui.widget.contextmenu.class_1853;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextInfoView;
   import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
   
   public class MysteryBoxContextMenuView extends FurnitureContextInfoView
   {
      
      private var var_4934:Boolean;
      
      public function MysteryBoxContextMenuView(param1:class_1853)
      {
         super(param1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(var_16 == null || var_16.assets == null || var_16.windowManager == null)
         {
            return;
         }
         if(var_530)
         {
            activeView = getMinimizedView();
         }
         else
         {
            if(_window == null || Boolean(_window.disposed))
            {
               _loc1_ = var_16.assets.getAssetByName("mysterybox_menu").content as XML;
               _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
               if(_window == null)
               {
                  return;
               }
               _window.addEventListener("WME_OVER",onMouseHoverEvent);
               _window.addEventListener("WME_OUT",onMouseHoverEvent);
               var _loc2_:class_1741 = _window.findChildByName("minimize");
            }
            _window.findChildByName("buttons").procedure = buttonEventProc;
            _window.visible = false;
            activeView = _window;
            var_200 = false;
            refreshOwnerMode();
         }
      }
      
      private function refreshOwnerMode() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.findChildByName("label").caption = "${mysterybox.context." + (var_4934 ? "owner" : "other") + ".use}";
      }
      
      override protected function buttonEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:FurnitureContextMenuWidget = null;
         if(disposed || _window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc3_:Boolean = false;
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc5_:* = param2.parent.name;
               if("use" === _loc5_)
               {
                  _loc4_ = var_16 as FurnitureContextMenuWidget;
                  if(_loc4_ != null)
                  {
                     _loc4_.showMysteryBoxOpenDialog(var_612);
                  }
               }
            }
            _loc3_ = true;
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
      
      public function set isOwnerMode(param1:Boolean) : void
      {
         var_4934 = param1;
         refreshOwnerMode();
      }
   }
}

