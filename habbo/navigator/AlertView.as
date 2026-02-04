package com.sulake.habbo.navigator
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class AlertView implements class_13
   {
      
      private static var var_1518:Dictionary = new Dictionary();
      
      private var _navigator:class_42;
      
      protected var var_473:class_2250;
      
      protected var _xmlFileName:String;
      
      protected var var_839:String;
      
      protected var _disposed:Boolean;
      
      public function AlertView(param1:class_42, param2:String, param3:String = null)
      {
         super();
         _navigator = param1;
         _xmlFileName = param2;
         var_839 = param3;
      }
      
      public static function findAlertView(param1:class_1741) : AlertView
      {
         if(var_1518 != null)
         {
            for each(var _loc2_ in var_1518)
            {
               if(_loc2_.var_473 == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function show() : void
      {
         var _loc2_:AlertView = var_1518[_xmlFileName] as AlertView;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         var_473 = getAlertWindow();
         if(var_839 != null)
         {
            var_473.caption = var_839;
         }
         setupAlertWindow(var_473);
         var _loc1_:Rectangle = Util.getLocationRelativeTo(var_473.desktop,var_473.width,var_473.height);
         var_473.x = _loc1_.x;
         var_473.y = _loc1_.y;
         var_1518[_xmlFileName] = this;
         var_473.activate();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(var_1518[_xmlFileName] == this)
         {
            var_1518[_xmlFileName] = null;
         }
         _disposed = true;
         if(var_473 != null)
         {
            var_473.destroy();
            var_473 = null;
         }
         _navigator = null;
      }
      
      internal function setupAlertWindow(param1:class_2250) : void
      {
      }
      
      internal function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function getAlertWindow() : class_2250
      {
         var _loc2_:class_2250 = _navigator.getXmlWindow(this._xmlFileName,2) as class_2250;
         var _loc1_:class_1741 = _loc2_.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
         return _loc2_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get navigator() : class_42
      {
         return _navigator;
      }
   }
}

