package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.IVector3d;
   
   [SecureSWF(rename="true")]
   public class class_1957
   {
      
      private var var_3595:Vector.<class_2862> = new Vector.<class_2862>();
      
      private var var_3713:Vector.<class_2862> = new Vector.<class_2862>();
      
      private var var_1199:Vector.<class_2927> = new Vector.<class_2927>();
      
      private var var_2676:Vector.<class_2927> = new Vector.<class_2927>();
      
      private var var_2586:Vector.<class_2927> = new Vector.<class_2927>();
      
      public function class_1957(param1:IMessageDataWrapper = null)
      {
         super();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
      }
      
      public function get baseParts() : Vector.<class_2862>
      {
         return var_3595;
      }
      
      public function get layerParts() : Vector.<class_2862>
      {
         return var_3713;
      }
      
      public function get badgeColors() : Vector.<class_2927>
      {
         return var_1199;
      }
      
      public function get guildPrimaryColors() : Vector.<class_2927>
      {
         return var_2676;
      }
      
      public function get guildSecondaryColors() : Vector.<class_2927>
      {
         return var_2586;
      }
      
      public function findMatchingPrimaryColorId(param1:int) : int
      {
         if(param1 < 0 || var_1199.length <= 0 || var_1199.length < param1 || var_2676.length <= 0)
         {
            return 0;
         }
         return findClosestColor(var_1199[param1],var_2676);
      }
      
      public function findMatchingSecondaryColorId(param1:int) : int
      {
         if(param1 < 0 || var_1199.length <= 0 || var_1199.length < param1 || var_2586.length <= 0)
         {
            return 0;
         }
         return findClosestColor(var_1199[param1],var_2586);
      }
      
      private function findClosestColor(param1:class_2927, param2:Vector.<class_2927>) : int
      {
         var _loc8_:int = 0;
         var _loc5_:IVector3d = null;
         var _loc6_:Number = NaN;
         var _loc4_:IVector3d = ColorConverter.rgb2CieLab(param1.color);
         var _loc7_:int = 0;
         var _loc3_:Number = 1.7976931348623157e+308;
         _loc8_ = 0;
         while(_loc8_ < param2.length)
         {
            _loc5_ = ColorConverter.rgb2CieLab(param2[_loc8_].color);
            _loc6_ = Math.pow(_loc4_.x - _loc5_.x,2) + Math.pow(_loc4_.y - _loc5_.y,2) + Math.pow(_loc4_.z - _loc5_.z,2);
            if(_loc6_ < _loc3_)
            {
               _loc3_ = _loc6_;
               _loc7_ = _loc8_;
            }
            _loc8_++;
         }
         return param2[_loc7_].id;
      }
   }
}

