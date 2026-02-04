package com.sulake.habbo.utils
{
   import flash.utils.Dictionary;
   
   public class FigureDataContainer
   {
      
      public static const MALE:String = "M";
      
      public static const const_118:String = "F";
      
      public static const const_103:String = "U";
      
      public static const SCALE:String = "h";
      
      public static const ACTION:String = "std";
      
      public static const DEFAULT_FRAME:String = "0";
      
      public static const const_54:String = "hd";
      
      public static const HAIR:String = "hr";
      
      public static const HAT:String = "ha";
      
      public static const HEAD_ACCESSORIES:String = "he";
      
      public static const EYE_ACCESSORIES:String = "ea";
      
      public static const FACE_ACCESSORIES:String = "fa";
      
      public static const JACKET:String = "cc";
      
      public static const SHIRT:String = "ch";
      
      public static const CHEST_ACCESSORIES:String = "ca";
      
      public static const CHEST_PRINTS:String = "cp";
      
      public static const TROUSERS:String = "lg";
      
      public static const SHOES:String = "sh";
      
      public static const TROUSER_ACCESSORIES:String = "wa";
      
      private static const BLOCKED_FX_TYPES:Array = [28,29,30,33,34,35,36,37,38,39,40,41,42,43,68];
      
      private var var_24:Dictionary;
      
      private var _colors:Dictionary;
      
      private var var_111:String = "M";
      
      private var var_1134:Boolean;
      
      private var var_3657:int = -1;
      
      public function FigureDataContainer()
      {
         super();
      }
      
      public function loadAvatarData(param1:String, param2:String) : void
      {
         var_24 = new Dictionary();
         _colors = new Dictionary();
         var_111 = param2;
         parseFigureString(param1);
      }
      
      public function dispose() : void
      {
         var_24 = null;
         _colors = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function parseFigureString(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         for each(var _loc7_ in param1.split("."))
         {
            _loc2_ = _loc7_.split("-");
            if(_loc2_.length > 0)
            {
               _loc6_ = String(_loc2_[0]);
               _loc3_ = parseInt(_loc2_[1]);
               _loc5_ = [];
               _loc4_ = 2;
               while(_loc4_ < _loc2_.length)
               {
                  _loc5_.push(parseInt(_loc2_[_loc4_]));
                  _loc4_++;
               }
               if(_loc5_.length == 0)
               {
                  _loc5_.push(0);
               }
               savePartSetId(_loc6_,_loc3_,false);
               savePartSetColourId(_loc6_,_loc5_,false);
            }
         }
      }
      
      public function hasSetType(param1:String) : Boolean
      {
         return var_24[param1] != null;
      }
      
      public function getPartSetId(param1:String) : int
      {
         if(var_24[param1] != null)
         {
            return var_24[param1];
         }
         return -1;
      }
      
      public function getColourIds(param1:String) : Array
      {
         if(_colors[param1] != null)
         {
            return _colors[param1];
         }
         return [];
      }
      
      public function getFigureString() : String
      {
         var _loc2_:String = null;
         var _loc8_:Array = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:String = "";
         var _loc1_:Array = [];
         for(var _loc7_ in var_24)
         {
            if(var_24[_loc7_] != null)
            {
               _loc2_ = var_24[_loc7_];
               _loc8_ = _colors[_loc7_] as Array;
               _loc3_ = _loc7_ + "-" + _loc2_;
               if(_loc8_)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc8_.length)
                  {
                     _loc3_ += "-" + _loc8_[_loc4_];
                     _loc4_++;
                  }
               }
               _loc1_.push(_loc3_);
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc6_ += _loc1_[_loc5_];
            if(_loc5_ < _loc1_.length - 1)
            {
               _loc6_ += ".";
            }
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function savePartData(param1:String, param2:int, param3:Array, param4:Boolean = false) : void
      {
         savePartSetId(param1,param2,param4);
         savePartSetColourId(param1,param3,param4);
      }
      
      private function savePartSetId(param1:String, param2:int, param3:Boolean = true) : void
      {
         switch(param1)
         {
            case "hd":
            case "hr":
            case "ha":
            case "he":
            case "ea":
            case "fa":
            case "ch":
            case "cc":
            case "ca":
            case "cp":
            case "lg":
            case "sh":
            case "wa":
               if(param2 >= 0)
               {
                  var_24[param1] = param2;
                  break;
               }
               delete var_24[param1];
               break;
            default:
               class_21.log("[FigureData] Unknown partset: " + param1 + ", can not store id: " + param2);
         }
      }
      
      public function savePartSetColourId(param1:String, param2:Array, param3:Boolean = true) : void
      {
         switch(param1)
         {
            case "hd":
            case "hr":
            case "ha":
            case "he":
            case "ea":
            case "fa":
            case "ch":
            case "cc":
            case "ca":
            case "cp":
            case "lg":
            case "sh":
            case "wa":
               _colors[param1] = param2;
               break;
            default:
               class_21.log("[FigureData] Unknown partset: " + param1 + ", can not store color-ids");
         }
      }
      
      public function getFigureStringWithFace(param1:int) : String
      {
         var _loc4_:int = 0;
         var _loc10_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = [];
         _loc3_.push("hd");
         var _loc8_:String = "";
         var _loc2_:Array = [];
         for each(var _loc9_ in _loc3_)
         {
            if(_colors[_loc9_] != null)
            {
               _loc4_ = int(var_24[_loc9_]);
               _loc10_ = _colors[_loc9_] as Array;
               if(_loc9_ == "hd")
               {
                  _loc4_ = param1;
               }
               _loc5_ = _loc9_ + "-" + _loc4_;
               if(_loc4_ >= 0)
               {
                  _loc6_ = 0;
                  while(_loc6_ < _loc10_.length)
                  {
                     _loc5_ += "-" + _loc10_[_loc6_];
                     _loc6_++;
                  }
               }
               _loc2_.push(_loc5_);
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc8_ += _loc2_[_loc7_];
            if(_loc7_ < _loc2_.length - 1)
            {
               _loc8_ += ".";
            }
            _loc7_++;
         }
         return _loc8_;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
   }
}

