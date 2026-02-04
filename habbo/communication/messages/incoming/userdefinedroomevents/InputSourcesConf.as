package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class InputSourcesConf
   {
      
      public static const FURNI_SOURCE_FURNI_PICKS_1:int = 100;
      
      public static const FURNI_SOURCE_FURNI_PICKS_2:int = 101;
      
      private var var_5369:int = 110;
      
      private var var_3398:Array;
      
      private var var_3629:Array;
      
      private var var_1929:Array;
      
      private var var_3291:Array;
      
      public function InputSourcesConf(param1:IMessageDataWrapper)
      {
         super();
         var_3398 = readAllowedSources(param1);
         var_3629 = readAllowedSources(param1);
         var_1929 = readDefaultSources(param1);
         var_3291 = readDefaultSources(param1);
      }
      
      private static function readAllowedSources(param1:IMessageDataWrapper) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Array = [];
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_[_loc4_] = [];
            _loc5_ = param1.readInteger();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_[_loc4_][_loc6_] = param1.readInteger();
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private static function readDefaultSources(param1:IMessageDataWrapper) : Array
      {
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(param1.readInteger());
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get amountFurniSelections() : int
      {
         return var_3398.length;
      }
      
      public function getAllowedFurniSources(param1:int) : Array
      {
         return var_3398[param1];
      }
      
      public function get amountUserSelections() : int
      {
         return var_3629.length;
      }
      
      public function getAllowedUserSources(param1:int) : Array
      {
         return var_3629[param1];
      }
      
      public function get defaultFurniSources() : Array
      {
         return var_1929;
      }
      
      public function get defaultUserSources() : Array
      {
         return var_3291;
      }
      
      public function isUsingAdvancedSettings(param1:Array, param2:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < var_1929.length)
         {
            _loc4_ = int(var_1929[_loc5_]);
            if(_loc4_ != param1[_loc5_])
            {
               return true;
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < var_3291.length)
         {
            _loc3_ = int(var_3291[_loc5_]);
            if(_loc3_ != param2[_loc5_])
            {
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function allowFurniSelection() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < amountFurniSelections)
         {
            if(getAllowedFurniSources(_loc1_).indexOf(100) != -1 || getAllowedFurniSources(_loc1_).indexOf(101) != -1 || getAllowedFurniSources(_loc1_).indexOf(var_5369) != -1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function isDualFurniPickingMode() : Boolean
      {
         var _loc1_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < amountFurniSelections)
         {
            if(getAllowedFurniSources(_loc1_).indexOf(100) != -1)
            {
               _loc3_ = true;
            }
            if(getAllowedFurniSources(_loc1_).indexOf(101) != -1)
            {
               _loc2_ = true;
            }
            _loc1_++;
         }
         return _loc3_ && _loc2_;
      }
      
      public function isFurniSelectionDefault() : Boolean
      {
         return var_1929.indexOf(100) != -1 || var_1929.indexOf(101) != -1;
      }
   }
}

