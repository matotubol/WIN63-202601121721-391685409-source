package com.sulake.habbo.friendbar.view.tabs
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class class_2992 extends Tab
   {
      
      protected static const ICON:String = "icon";
      
      protected static const const_1233:String = "text";
      
      protected static const HEADER:String = "header";
      
      protected static const LABEL:String = "label";
      
      protected static const const_89:String = "button";
      
      private static const const_223:String = "add_friends_tab_xml";
      
      private static const ICON_RESOURCE:String = "find_friends_icon_png";
      
      private static var var_2212:int = -1;
      
      private static const DEFAULT_COLOR:uint = 8374494;
      
      private static const const_145:uint = 9560569;
      
      private static const const_17:Array = [];
      
      private static const const_18:Array = [];
      
      public function class_2992()
      {
         super();
      }
      
      public static function allocate() : class_2992
      {
         var _loc1_:class_2992 = const_17.length > 0 ? const_17.pop() : new class_2992();
         _loc1_.var_123 = false;
         _loc1_._window = _loc1_.allocateEntityWindow();
         return _loc1_;
      }
      
      public function allocateEntityWindow() : class_1812
      {
         var _loc1_:class_1812 = const_18.length > 0 ? const_18.pop() : WINDOWING.buildFromXML(ASSETS.getAssetByName("add_friends_tab_xml").content as XML) as class_1812;
         var _loc4_:IRegionWindow = IRegionWindow(_loc1_.findChildByName("header"));
         _loc1_.addEventListener("WME_CLICK",onMouseClick);
         _loc1_.addEventListener("WME_OVER",onMouseOver);
         _loc1_.addEventListener("WME_OUT",onMouseOut);
         _loc4_.addEventListener("WME_CLICK",onMouseClick);
         _loc4_.addEventListener("WME_OVER",onMouseOver);
         _loc4_.addEventListener("WME_OUT",onMouseOut);
         if(var_2212 < 0)
         {
            var_2212 = _loc1_.height;
         }
         _loc1_.height = HEIGHT;
         var _loc3_:class_2251 = _loc1_.findChildByName("icon") as class_2251;
         _loc3_.disposesBitmap = false;
         if(ASSETS.getAssetByName("find_friends_icon_png") != null)
         {
            _loc3_.bitmap = ASSETS.getAssetByName("find_friends_icon_png").content as BitmapData;
         }
         var _loc2_:class_1741 = _loc1_.findChildByName("button");
         _loc2_.addEventListener("WME_CLICK",onButtonClick);
         var _loc5_:class_1741 = _loc1_.findChildByName("text");
         _loc5_.visible = false;
         return _loc1_;
      }
      
      private function releaseEntityWindow(param1:class_1812) : void
      {
         var _loc2_:IRegionWindow = null;
         if(param1 && !param1.disposed)
         {
            param1.procedure = null;
            param1.removeEventListener("WME_CLICK",onMouseClick);
            param1.removeEventListener("WME_OVER",onMouseOver);
            param1.removeEventListener("WME_OUT",onMouseOut);
            _loc2_ = IRegionWindow(param1.findChildByName("header"));
            _loc2_.removeEventListener("WME_CLICK",onMouseClick);
            _loc2_.removeEventListener("WME_OVER",onMouseOver);
            _loc2_.removeEventListener("WME_OUT",onMouseOut);
            param1.findChildByName("button").removeEventListener("WME_CLICK",onButtonClick);
            param1.findChildByName("text").visible = false;
            param1.width = WIDTH;
            param1.height = HEIGHT;
            if(const_18.indexOf(param1) == -1)
            {
               const_18.push(param1);
            }
         }
      }
      
      override public function select(param1:Boolean) : void
      {
         if(!selected)
         {
            _window.height = var_2212;
            _window.y -= _window.height - HEIGHT;
            _window.findChildByName("text").visible = true;
            super.select(param1);
         }
      }
      
      override public function deselect(param1:Boolean) : void
      {
         if(selected)
         {
            _window.y = 0;
            _window.height = HEIGHT;
            _window.findChildByName("text").visible = false;
            super.deselect(param1);
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
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      override protected function conceal() : void
      {
         super.conceal();
         ITextWindow(_window.findChildByTag("label")).underline = exposed;
         _window.color = exposed ? 9560569 : 8374494;
      }
      
      private function onButtonClick(param1:WindowMouseEvent) : void
      {
         if(!disposed && !recycled)
         {
            DATA.findNewFriends();
            deselect(true);
         }
      }
   }
}

