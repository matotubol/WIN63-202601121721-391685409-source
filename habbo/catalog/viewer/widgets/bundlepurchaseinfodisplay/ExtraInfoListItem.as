package com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   
   public class ExtraInfoListItem implements class_13
   {
      
      public static const ALIGN_TOP:int = 0;
      
      public static const ALIGN_BOTTOM:int = 1;
      
      public static const ALIGN_OVERLAY:int = 2;
      
      private var var_197:int;
      
      private var var_24:ExtraInfoItemData;
      
      private var var_2733:int;
      
      private var var_5130:Boolean;
      
      private var _disposed:Boolean = false;
      
      private var var_4548:Number;
      
      private var var_4518:Number;
      
      private var var_4061:Boolean = false;
      
      public function ExtraInfoListItem(param1:BundlePurchaseExtraInfoWidget, param2:int, param3:ExtraInfoItemData, param4:int = 0, param5:Boolean = false)
      {
         super();
         var_197 = param2;
         var_24 = param3;
         var_2733 = param4;
         var_5130 = param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var_24 = null;
         _disposed = true;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
      
      public function get data() : ExtraInfoItemData
      {
         return var_24;
      }
      
      public function set data(param1:ExtraInfoItemData) : void
      {
         var_24 = param1;
      }
      
      public function get alignment() : int
      {
         return var_2733;
      }
      
      public function get alwaysOnTop() : Boolean
      {
         return var_5130;
      }
      
      public function get creationSeconds() : Number
      {
         return var_4548;
      }
      
      public function set creationSeconds(param1:Number) : void
      {
         var_4548 = param1;
      }
      
      public function get isItemRemoved() : Boolean
      {
         return var_4061;
      }
      
      public function get removalSeconds() : Number
      {
         return var_4518;
      }
      
      public function set removalSeconds(param1:Number) : void
      {
         var_4518 = param1;
         var_4061 = true;
      }
      
      public function getRenderedWindow() : class_1812
      {
         return null;
      }
   }
}

