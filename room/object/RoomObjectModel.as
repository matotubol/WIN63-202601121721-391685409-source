package com.sulake.room.object
{
   import com.sulake.core.utils.class_55;
   import flash.utils.Dictionary;
   
   public class RoomObjectModel implements IRoomObjectModelController
   {
      
      private static const MAP_KEYS_PREFIX:String = "ROMC_MAP_KEYS_";
      
      private static const MAP_VALUES_PREFIX:String = "ROMC_MAP_VALUES_";
      
      private var var_890:Dictionary;
      
      private var var_961:Dictionary;
      
      private var var_1029:Dictionary;
      
      private var var_968:Dictionary;
      
      private var var_2393:Array;
      
      private var var_2597:Array;
      
      private var var_2497:Array;
      
      private var var_2356:Array;
      
      private var var_50:int;
      
      public function RoomObjectModel()
      {
         super();
         var_890 = new Dictionary();
         var_961 = new Dictionary();
         var_1029 = new Dictionary();
         var_968 = new Dictionary();
         var_2393 = [];
         var_2597 = [];
         var_2497 = [];
         var_2356 = [];
         var_50 = 0;
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         if(var_890 != null)
         {
            for(_loc1_ in var_890)
            {
               delete var_890[_loc1_];
            }
            var_890 = null;
         }
         if(var_961 != null)
         {
            for(_loc1_ in var_961)
            {
               delete var_961[_loc1_];
            }
            var_961 = null;
         }
         if(var_1029 != null)
         {
            for(_loc1_ in var_1029)
            {
               delete var_1029[_loc1_];
            }
            var_1029 = null;
         }
         if(var_968 != null)
         {
            for(_loc1_ in var_968)
            {
               delete var_968[_loc1_];
            }
            var_968 = null;
         }
         var_2597 = [];
         var_2393 = [];
         var_2356 = [];
         var_2497 = [];
      }
      
      public function hasNumber(param1:String) : Boolean
      {
         return var_890[param1] != null;
      }
      
      public function hasNumberArray(param1:String) : Boolean
      {
         return var_1029[param1] != null;
      }
      
      public function hasString(param1:String) : Boolean
      {
         return var_961[param1] != null;
      }
      
      public function hasStringArray(param1:String) : Boolean
      {
         return var_968[param1] != null;
      }
      
      public function getNumber(param1:String) : Number
      {
         return var_890[param1];
      }
      
      public function getString(param1:String) : String
      {
         return var_961[param1];
      }
      
      public function getNumberArray(param1:String) : Array
      {
         var _loc2_:Array = var_1029[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringArray(param1:String) : Array
      {
         var _loc2_:Array = var_968[param1];
         if(_loc2_ != null)
         {
            _loc2_ = _loc2_.slice();
         }
         return _loc2_;
      }
      
      public function getStringToStringMap(param1:String) : class_55
      {
         var _loc4_:int = 0;
         var _loc5_:class_55 = new class_55();
         var _loc2_:Array = getStringArray("ROMC_MAP_KEYS_" + param1);
         var _loc3_:Array = getStringArray("ROMC_MAP_VALUES_" + param1);
         if(_loc2_ != null && _loc3_ != null && _loc2_.length == _loc3_.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_.add(_loc2_[_loc4_],_loc3_[_loc4_]);
               _loc4_++;
            }
         }
         return _loc5_;
      }
      
      public function setNumber(param1:String, param2:Number, param3:Boolean = false) : void
      {
         if(var_2393.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_2393.push(param1);
         }
         if(var_890[param1] != param2)
         {
            var_890[param1] = param2;
            var_50 = var_50 + 1;
         }
      }
      
      public function setString(param1:String, param2:String, param3:Boolean = false) : void
      {
         if(var_2597.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_2597.push(param1);
         }
         if(var_961[param1] != param2)
         {
            var_961[param1] = param2;
            var_50 = var_50 + 1;
         }
      }
      
      public function setNumberArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(var_2497.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_2497.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is Number)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = var_1029[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as Number != _loc5_[_loc7_] as Number)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         var_1029[param1] = _loc6_;
         var_50 = var_50 + 1;
      }
      
      public function setStringArray(param1:String, param2:Array, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(var_2356.indexOf(param1) >= 0)
         {
            return;
         }
         if(param3)
         {
            var_2356.push(param1);
         }
         var _loc6_:Array = [];
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < param2.length)
         {
            if(param2[_loc7_] is String)
            {
               _loc6_.push(param2[_loc7_]);
            }
            _loc7_++;
         }
         var _loc5_:Array = var_968[param1];
         var _loc4_:Boolean = true;
         if(_loc5_ != null && _loc5_.length == _loc6_.length)
         {
            _loc7_ = _loc6_.length - 1;
            while(_loc7_ >= 0)
            {
               if(_loc6_[_loc7_] as String != _loc5_[_loc7_] as String)
               {
                  _loc4_ = false;
                  break;
               }
               _loc7_--;
            }
         }
         else
         {
            _loc4_ = false;
         }
         if(_loc4_)
         {
            return;
         }
         var_968[param1] = _loc6_;
         var_50 = var_50 + 1;
      }
      
      public function setStringToStringMap(param1:String, param2:class_55, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            return;
         }
         setStringArray("ROMC_MAP_KEYS_" + param1,param2.getKeys(),param3);
         setStringArray("ROMC_MAP_VALUES_" + param1,param2.getValues(),param3);
      }
      
      public function getUpdateID() : int
      {
         return var_50;
      }
   }
}

