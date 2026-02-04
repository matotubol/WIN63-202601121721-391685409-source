package com.sulake.habbo.ui.widget.avatarinfo
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.class_1758;
   
   public class DecorateModeView extends AvatarContextInfoButtonView
   {
      
      public function DecorateModeView(param1:AvatarInfoWidget, param2:int, param3:String, param4:int)
      {
         super(param1);
         var_236 = false;
         AvatarContextInfoButtonView.setup(this,param2,param3,param4,1);
      }
      
      override protected function updateWindow() : void
      {
         var _loc1_:XML = null;
         if(!var_16 || !var_16.assets || !var_16.windowManager)
         {
            return;
         }
         if(!_window)
         {
            _loc1_ = XmlAsset(var_16.assets.getAssetByName("own_avatar_decorating")).content as XML;
            _window = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
            if(!_window)
            {
               return;
            }
            _window.addEventListener("WME_OVER",onMouseHoverEvent);
            _window.addEventListener("WME_OUT",onMouseHoverEvent);
            var_34 = _window.findChildByName("buttons") as IItemListWindow;
            var_34.procedure = eventProc;
            updateButtons();
         }
         activeView = _window;
      }
      
      override public function show() : void
      {
         if(var_125 != null)
         {
            var_125.visible = true;
            var_125.activate();
         }
      }
      
      override public function hide(param1:Boolean) : void
      {
         if(var_125 != null)
         {
            var_125.visible = false;
         }
         var_200 = false;
      }
      
      override protected function set activeView(param1:class_1812) : void
      {
         if(!param1)
         {
            return;
         }
         var_125 = param1;
      }
      
      public function isVisible() : Boolean
      {
         return var_125 && var_125.visible;
      }
      
      public function updateButtons() : void
      {
         showButton("decorate");
      }
      
      private function eventProc(param1:class_1758, param2:class_1741) : void
      {
         if(disposed)
         {
            return;
         }
         if(!_window || Boolean(_window.disposed))
         {
            return;
         }
         if(param1.type == "WME_CLICK")
         {
            if(param2.name == "button")
            {
               var _loc3_:* = param2.parent.name;
               if("decorate" === _loc3_)
               {
                  widget.isUserDecorating = false;
               }
            }
         }
         else if(param1.type == "WME_OVER")
         {
            super.buttonEventProc(param1,param2);
            var_200 = true;
         }
         else if(param1.type == "WME_OUT")
         {
            super.buttonEventProc(param1,param2);
            var_200 = false;
         }
         else
         {
            super.buttonEventProc(param1,param2);
         }
      }
      
      override public function get maximumBlend() : Number
      {
         return 0.8;
      }
      
      private function get widget() : AvatarInfoWidget
      {
         return var_16 as AvatarInfoWidget;
      }
   }
}

