package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class class_3069 extends Tab
   {
      
      protected static const ICON:String = "icon";
      
      protected static const HEADER:String = "header";
      
      private static const const_223:String = "new_open_messenger_tab_xml";
      
      private static const DEFAULT_COLOR:uint = 8374494;
      
      private static const const_145:uint = 9560569;
      
      private static const FRIENDS_Y_PADDING:int = 10;
      
      private static const const_17:Array = [];
      
      private static const const_18:Array = [];
      
      public function class_3069()
      {
         super();
      }
      
      public static function allocate() : class_3069
      {
         var _loc1_:class_3069 = const_17.length > 0 ? const_17.pop() : new class_3069();
         _loc1_.var_123 = false;
         _loc1_._window = _loc1_.allocateEntityWindow();
         return _loc1_;
      }
      
      public function allocateEntityWindow() : class_1812
      {
         var _loc1_:class_1812 = const_18.length > 0 ? const_18.pop() : WINDOWING.buildFromXML(ASSETS.getAssetByName("new_open_messenger_tab_xml").content as XML) as class_1812;
         _loc1_.addEventListener("WME_CLICK",onButtonClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc1_.height = HEIGHT;
         return _loc1_;
      }
      
      private function releaseEntityWindow(param1:class_1812) : void
      {
         if(param1 && !param1.disposed)
         {
            param1.procedure = null;
            param1.removeEventListener("WME_CLICK",onMouseClick);
            param1.removeEventListener("WME_OVER",onMouseOver);
            param1.removeEventListener("WME_OUT",onMouseOut);
            param1.width = WIDTH;
            param1.height = HEIGHT;
            if(const_18.indexOf(param1) == -1)
            {
               const_18.push(param1);
            }
         }
      }
      
      override public function recycle() : void
      {
         if(!disposed)
         {
            if(!var_123)
            {
               if(_window)
               {
                  releaseEntityWindow(_window);
                  _window = null;
               }
               var_123 = true;
               const_17.push(this);
            }
         }
      }
      
      override protected function expose() : void
      {
         super.expose();
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      private function onButtonClick(param1:WindowMouseEvent) : void
      {
         if(!disposed && !recycled)
         {
            DATA.toggleMessenger();
         }
      }
   }
}

