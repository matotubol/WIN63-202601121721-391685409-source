package com.sulake.habbo.avatar.structure.figure
{
   public class FigurePartSet implements class_1932
   {
      
      private var var_230:String;
      
      private var var_197:int;
      
      private var var_111:String;
      
      private var var_2971:int;
      
      private var var_2093:Boolean;
      
      private var var_4896:Boolean;
      
      private var var_406:Array;
      
      private var _hiddenLayers:Array;
      
      private var var_4297:Boolean;
      
      private var var_4006:Boolean;
      
      public function FigurePartSet(param1:XML, param2:String)
      {
         super();
         var_230 = param2;
         var_197 = parseInt(param1.@id);
         var_111 = String(param1.@gender);
         var_2971 = parseInt(param1.@club);
         var_2093 = Boolean(parseInt(param1.@colorable));
         var_4896 = Boolean(parseInt(param1.@selectable));
         var_4297 = Boolean(parseInt(param1.@preselectable));
         var_4006 = Boolean(parseInt(param1.@sellable));
         var_406 = [];
         _hiddenLayers = [];
         for each(var _loc4_ in param1.part)
         {
            var _loc3_:FigurePart = new FigurePart(_loc4_);
            var _loc5_:int = indexOfPartType(null);
            if(_loc5_ != -1)
            {
               var_406.splice(0,0,null);
            }
            else
            {
               var_406.push(null);
            }
         }
         for each(var _loc6_ in param1.hiddenlayers.layer)
         {
            _hiddenLayers.push(String(_loc6_.@parttype));
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in var_406)
         {
            _loc1_.dispose();
         }
         var_406 = null;
         _hiddenLayers = null;
      }
      
      private function indexOfPartType(param1:FigurePart) : int
      {
         var _loc3_:int = 0;
         var _loc2_:FigurePart = null;
         _loc3_ = 0;
         while(_loc3_ < var_406.length)
         {
            _loc2_ = var_406[_loc3_];
            if(_loc2_.type == param1.type && _loc2_.index < param1.index)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getPart(param1:String, param2:int) : class_3134
      {
         for each(var _loc3_ in var_406)
         {
            if(_loc3_.type == param1 && _loc3_.id == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
      
      public function get isColorable() : Boolean
      {
         return var_2093;
      }
      
      public function get isSelectable() : Boolean
      {
         return var_4896;
      }
      
      public function get parts() : Array
      {
         return var_406;
      }
      
      public function get hiddenLayers() : Array
      {
         return _hiddenLayers;
      }
      
      public function get isPreSelectable() : Boolean
      {
         return var_4297;
      }
      
      public function get isSellable() : Boolean
      {
         return var_4006;
      }
   }
}

