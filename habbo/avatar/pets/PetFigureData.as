package com.sulake.habbo.avatar.pets
{
   public class PetFigureData
   {
      
      private var var_3814:int;
      
      private var var_3349:int;
      
      private var _color:int;
      
      private var var_2365:Array;
      
      private var var_1975:Array;
      
      private var var_3052:Array;
      
      private var var_3168:Array;
      
      private var _headOnly:Boolean;
      
      public function PetFigureData(param1:String)
      {
         super();
         var_3814 = getTypeId(param1);
         var_3349 = getPaletteId(param1);
         _color = getColor(param1);
         _headOnly = getHeadOnly(param1);
         var _loc3_:Array = getCustomData(param1);
         var_1975 = getCustomLayerIds(_loc3_);
         var_3052 = getCustomPartIds(_loc3_);
         var_3168 = getCustomPaletteIds(_loc3_);
         var_2365 = [];
         var _loc2_:int = 0;
         while(0 < var_1975.length)
         {
            var_2365.push(new PetCustomPart(var_1975[0],var_3052[0],var_3168[0]));
            _loc2_++;
         }
      }
      
      public function get typeId() : int
      {
         return var_3814;
      }
      
      public function get paletteId() : int
      {
         return var_3349;
      }
      
      public function get color() : int
      {
         return _color;
      }
      
      public function get customLayerIds() : Array
      {
         return var_1975;
      }
      
      public function get customPartIds() : Array
      {
         return var_3052;
      }
      
      public function get customPaletteIds() : Array
      {
         return var_3168;
      }
      
      public function get customParts() : Array
      {
         return var_2365;
      }
      
      public function getCustomPart(param1:int) : PetCustomPart
      {
         if(var_2365 != null)
         {
            for each(var _loc2_ in var_2365)
            {
               if(_loc2_.layerId == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function get hasCustomParts() : Boolean
      {
         return var_1975 != null && var_1975.length > 0;
      }
      
      public function get headOnly() : Boolean
      {
         return _headOnly;
      }
      
      public function get figureString() : String
      {
         var _loc2_:String = typeId + " " + paletteId + " " + color.toString(16);
         _loc2_ += " " + customParts.length;
         for each(var _loc1_ in customParts)
         {
            _loc2_ += " " + _loc1_.layerId + " " + _loc1_.partId + " " + _loc1_.paletteId;
         }
         return _loc2_;
      }
      
      private function getCustomData(param1:String) : Array
      {
         var _loc7_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         if(param1 != null)
         {
            _loc7_ = param1.split(" ");
            _loc4_ = _headOnly ? 1 : 0;
            _loc5_ = 4 + _loc4_;
            if(_loc7_.length > _loc5_)
            {
               _loc2_ = 3 + _loc4_;
               _loc6_ = parseInt(_loc7_[_loc2_]);
               _loc3_ = _loc7_.slice(_loc5_,_loc5_ + _loc6_ * 3);
            }
         }
         return _loc3_;
      }
      
      private function getCustomLayerIds(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(parseInt(param1[_loc3_ + 0]));
            _loc3_ += 3;
         }
         return _loc2_;
      }
      
      private function getCustomPartIds(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(parseInt(param1[_loc3_ + 1]));
            _loc3_ += 3;
         }
         return _loc2_;
      }
      
      private function getCustomPaletteIds(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(parseInt(param1[_loc3_ + 2]));
            _loc3_ += 3;
         }
         return _loc2_;
      }
      
      private function getTypeId(param1:String) : int
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length >= 1)
            {
               return parseInt(_loc2_[0]);
            }
         }
         return 0;
      }
      
      private function getPaletteId(param1:String) : int
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length >= 2)
            {
               return parseInt(_loc2_[1]);
            }
         }
         return 0;
      }
      
      private function getColor(param1:String) : int
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length >= 3)
            {
               return parseInt(_loc2_[2],16);
            }
         }
         return 16777215;
      }
      
      private function getHeadOnly(param1:String) : Boolean
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length >= 4)
            {
               return _loc2_[3] == "head";
            }
         }
         return false;
      }
   }
}

