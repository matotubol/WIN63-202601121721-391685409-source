package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePart implements class_3134
   {
      
      private var var_197:int;
      
      private var var_230:String;
      
      private var var_4573:int = -1;
      
      private var var_4826:int;
      
      private var _index:int;
      
      private var var_4253:int = -1;
      
      public function FigurePart(param1:XML)
      {
         super();
         var_197 = parseInt(param1.@id);
         var_230 = String(param1.@type);
         _index = parseInt(param1.@index);
         var_4826 = parseInt(param1.@colorindex);
         var _loc2_:String = param1.@palettemapid;
         if(_loc2_ != "")
         {
            var_4253 = int(_loc2_);
         }
         var _loc3_:String = param1.@breed;
         if(_loc3_ != "")
         {
            var_4573 = int(_loc3_);
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get breed() : int
      {
         return var_4573;
      }
      
      public function get colorLayerIndex() : int
      {
         return var_4826;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get paletteMap() : int
      {
         return var_4253;
      }
   }
}

