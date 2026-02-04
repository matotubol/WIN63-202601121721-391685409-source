package com.sulake.habbo.catalog.viewer
{
   import com.sulake.habbo.window.widgets.IProductDisplayInfo;
   
   public class ProductDisplayWrapper implements IProductDisplayInfo
   {
      
      private var var_3727:class_1857;
      
      public function ProductDisplayWrapper(param1:class_1857)
      {
         super();
         var_3727 = param1;
      }
      
      public static function isSupported(param1:String) : Boolean
      {
         return param1 == "chat_style";
      }
      
      public function get productTypeId() : int
      {
         var _loc1_:* = var_3727.productType;
         if("chat_style" !== _loc1_)
         {
            return 0;
         }
         return 9;
      }
      
      public function get itemTypeId() : String
      {
         return var_3727.extraParam;
      }
      
      public function get petFigureString() : String
      {
         return "";
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return undefined;
      }
   }
}

