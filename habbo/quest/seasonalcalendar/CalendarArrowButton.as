package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class CalendarArrowButton
   {
      
      public static const DIRECTION_BACK:int = 0;
      
      public static const const_1149:int = 1;
      
      public static const STATE_INACTIVE:int = 0;
      
      public static const STATE_ACTIVE:int = 1;
      
      public static const STATE_HILITE:int = 2;
      
      private static const PRESSED_OFFSET_PIXELS:Point = new Point(1,1);
      
      private var _window:class_2251;
      
      private var _callback:Function;
      
      private var var_61:int = 0;
      
      private var _pressed:Boolean = false;
      
      private var var_2749:Point;
      
      private var var_2144:BitmapData;
      
      private var var_2048:BitmapData;
      
      private var var_2089:BitmapData;
      
      public function CalendarArrowButton(param1:class_40, param2:class_2251, param3:int, param4:Function)
      {
         super();
         _window = param2;
         _window.procedure = procedure;
         _callback = param4;
         switch(param3)
         {
            case 0:
               var_2048 = BitmapData(param1.getAssetByName("arrow_back_active").content).clone();
               var_2144 = BitmapData(param1.getAssetByName("arrow_back_inactive").content).clone();
               var_2089 = BitmapData(param1.getAssetByName("arrow_back_hilite").content).clone();
               break;
            case 1:
               var_2048 = BitmapData(param1.getAssetByName("arrow_next_active").content).clone();
               var_2144 = BitmapData(param1.getAssetByName("arrow_next_inactive").content).clone();
               var_2089 = BitmapData(param1.getAssetByName("arrow_next_hilite").content).clone();
         }
         var_2749 = new Point(_window.x,_window.y);
         updateWindow();
      }
      
      public function dispose() : void
      {
         var_2048 = null;
         var_2089 = null;
         var_2144 = null;
         _window.procedure = null;
         _window = null;
         _callback = null;
      }
      
      public function activate() : void
      {
         if(var_61 != 1 && var_61 != 2)
         {
            var_61 = 1;
         }
         updateWindow();
      }
      
      public function deactivate() : void
      {
         var_61 = 0;
         updateWindow();
      }
      
      public function isInactive() : Boolean
      {
         return var_61 == 0;
      }
      
      private function updateWindow() : void
      {
         switch(var_61)
         {
            case 0:
               _window.bitmap = var_2144;
               break;
            case 1:
               _window.bitmap = var_2048;
               break;
            case 2:
               _window.bitmap = var_2089;
         }
         if(_pressed)
         {
            _window.x = var_2749.x + PRESSED_OFFSET_PIXELS.x;
            _window.y = var_2749.y + PRESSED_OFFSET_PIXELS.y;
         }
         else
         {
            _window.position = var_2749;
         }
      }
      
      private function procedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1 as WindowMouseEvent != null)
         {
            switch(param1.type)
            {
               case "WME_OVER":
                  if(var_61 != 0)
                  {
                     var_61 = 2;
                  }
                  break;
               case "WME_OUT":
                  if(var_61 != 0)
                  {
                     var_61 = 1;
                  }
                  break;
               case "WME_DOWN":
                  _pressed = true;
                  break;
               case "WME_UP":
               case "WME_UP_OUTSIDE":
                  _pressed = false;
            }
            updateWindow();
            _callback(param1,param2);
         }
      }
   }
}

