package com.sulake.habbo.notifications.singular
{
   import com.sulake.core.utils.class_55;
   import flash.display.BitmapData;
   
   public class HabboNotificationItemStyle
   {
      
      private var _icon:BitmapData;
      
      private var var_3059:Boolean;
      
      private var var_4412:String;
      
      private var var_3305:String;
      
      private var _iconAssetUri:String;
      
      private var _customLayout:String;
      
      private var var_5060:String;
      
      private var var_4005:Array;
      
      private var _styleName:String;
      
      public function HabboNotificationItemStyle(param1:class_55, param2:BitmapData, param3:String, param4:Boolean, param5:String, param6:Array, param7:String)
      {
         super();
         _iconAssetUri = param3;
         if(param1 != null && param3 == null)
         {
            _icon = param1["icon"];
            var_3305 = param1["internallink"];
            _customLayout = param1["customlayout"];
            var_5060 = param1["customview"];
         }
         if(param2 != null)
         {
            _icon = param2;
            var_3059 = param4;
         }
         else
         {
            var_3059 = false;
         }
         var_4412 = param5;
         var_4005 = param6;
         _styleName = param7;
      }
      
      public function dispose() : void
      {
         if(var_3059 && _icon != null)
         {
            _icon.dispose();
            _icon = null;
         }
      }
      
      public function get icon() : BitmapData
      {
         return _icon;
      }
      
      public function get internalLink() : String
      {
         return var_3305;
      }
      
      public function set internalLink(param1:String) : void
      {
         var_3305 = param1;
      }
      
      public function get iconSrc() : String
      {
         return var_4412;
      }
      
      public function get iconAssetUri() : String
      {
         return _iconAssetUri;
      }
      
      public function get customLayout() : String
      {
         return _customLayout;
      }
      
      public function get customView() : String
      {
         return var_5060;
      }
      
      public function get extraData() : Array
      {
         return var_4005;
      }
      
      public function get styleName() : String
      {
         return _styleName;
      }
   }
}

