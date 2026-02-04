package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectMoveUpdateMessage extends RoomObjectUpdateMessage
   {
      
      private var var_318:IVector3d;
      
      private var _isSlideUpdate:Boolean;
      
      private var _animationTime:Number;
      
      private var _skipPositionUpdate:Boolean;
      
      public function RoomObjectMoveUpdateMessage(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:Number = NaN, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param3);
         _isSlideUpdate = param5;
         var_318 = param2;
         _animationTime = param4;
         _skipPositionUpdate = param6;
      }
      
      public function get targetLoc() : IVector3d
      {
         if(var_318 == null)
         {
            return loc;
         }
         return var_318;
      }
      
      public function get realTargetLoc() : IVector3d
      {
         return var_318;
      }
      
      public function get isSlideUpdate() : Boolean
      {
         return _isSlideUpdate;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
      
      public function get skipPositionUpdate() : Boolean
      {
         return _skipPositionUpdate;
      }
   }
}

