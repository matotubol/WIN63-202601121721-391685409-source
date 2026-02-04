package com.sulake.core.window.utils
{
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import flash.utils.Dictionary;
   
   public class MouseCursorControl
   {
      
      private static var var_230:uint = 0;
      
      private static var var_360:Stage;
      
      private static var var_588:Boolean = true;
      
      private static var _disposed:Boolean = false;
      
      private static var var_2923:Boolean = true;
      
      private static var var_317:DisplayObject;
      
      private static var var_3567:Dictionary = new Dictionary();
      
      public function MouseCursorControl(param1:DisplayObject)
      {
         super();
         var_360 = param1.stage;
      }
      
      public static function dispose() : void
      {
         if(!_disposed)
         {
            if(var_317)
            {
               var_360.removeChild(var_317);
               var_360.removeEventListener("mouseLeave",onStageMouseLeave);
               var_360.removeEventListener("mouseMove",onStageMouseMove);
               var_360.removeEventListener("mouseOver",onStageMouseMove);
               var_360.removeEventListener("mouseOut",onStageMouseMove);
            }
            _disposed = true;
         }
      }
      
      public static function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public static function get type() : uint
      {
         return var_230;
      }
      
      public static function set type(param1:uint) : void
      {
         if(var_230 != param1)
         {
            var_230 = param1;
            var_2923 = true;
         }
      }
      
      public static function get visible() : Boolean
      {
         return var_588;
      }
      
      public static function set visible(param1:Boolean) : void
      {
         var_588 = param1;
         if(var_588)
         {
            if(var_317)
            {
               var_317.visible = true;
            }
            else
            {
               Mouse.show();
            }
         }
         else if(var_317)
         {
            var_317.visible = false;
         }
         else
         {
            Mouse.hide();
         }
      }
      
      public static function change() : void
      {
         var _loc1_:DisplayObject = null;
         if(var_2923)
         {
            _loc1_ = var_3567[var_230];
            if(_loc1_)
            {
               if(var_317)
               {
                  var_360.removeChild(var_317);
               }
               else
               {
                  var_360.addEventListener("mouseLeave",onStageMouseLeave);
                  var_360.addEventListener("mouseMove",onStageMouseMove);
                  var_360.addEventListener("mouseOver",onStageMouseMove);
                  var_360.addEventListener("mouseOut",onStageMouseMove);
                  Mouse.hide();
               }
               var_317 = _loc1_;
               var_360.addChild(var_317);
            }
            else
            {
               if(var_317)
               {
                  var_360.removeChild(var_317);
                  var_360.removeEventListener("mouseLeave",onStageMouseLeave);
                  var_360.removeEventListener("mouseMove",onStageMouseMove);
                  var_360.removeEventListener("mouseOver",onStageMouseMove);
                  var_360.removeEventListener("mouseOut",onStageMouseMove);
                  var_317 = null;
                  Mouse.show();
               }
               switch(var_230)
               {
                  case 0:
                  case 1:
                     Mouse.cursor = "auto";
                     break;
                  case 2:
                     Mouse.cursor = "button";
                     break;
                  case 5:
                  case 6:
                  case 7:
                  case 8:
                     Mouse.cursor = "hand";
                     break;
                  case 14:
                     Mouse.cursor = "ibeam";
                     break;
                  case 4294967294:
                     Mouse.cursor = "auto";
                     Mouse.hide();
               }
            }
            var_2923 = false;
         }
      }
      
      public static function defineCustomCursorType(param1:uint, param2:DisplayObject) : void
      {
         var_3567[param1] = param2;
      }
      
      private static function onStageMouseMove(param1:MouseEvent) : void
      {
         if(var_317)
         {
            var_317.x = param1.stageX - 2;
            var_317.y = param1.stageY;
            if(var_230 == 0)
            {
               var_588 = false;
               Mouse.show();
            }
            else
            {
               var_588 = true;
               Mouse.hide();
            }
         }
      }
      
      private static function onStageMouseLeave(param1:Event) : void
      {
         if(var_317 && var_230 != 0)
         {
            Mouse.hide();
            var_588 = false;
         }
      }
   }
}

