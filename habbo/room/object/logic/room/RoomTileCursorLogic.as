package com.sulake.habbo.room.object.logic.room
{
   import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.object.logic.ObjectLogicBase;
   
   public class RoomTileCursorLogic extends ObjectLogicBase
   {
      
      private static const STATE_ENABLED:int = 0;
      
      private static const STATE_DISABLED:int = 1;
      
      private static const STATE_SHOW_TILE_HEIGHT:int = 6;
      
      private var var_3660:String;
      
      private var _hiddenOnPurpose:Boolean;
      
      public function RoomTileCursorLogic()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc2_:IRoomObjectModelController = null;
         if(object != null)
         {
            _loc2_ = object.getModelController();
            if(_loc2_ != null)
            {
               _loc2_.setNumber("furniture_alpha_multiplier",1);
               object.setState(1,0);
            }
         }
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:RoomObjectTileCursorUpdateMessage = param1 as RoomObjectTileCursorUpdateMessage;
         if(_loc2_ == null)
         {
            return;
         }
         if(var_3660 != null && var_3660 == _loc2_.sourceEventId)
         {
            return;
         }
         if(_loc2_.toggleVisibility)
         {
            _hiddenOnPurpose = !_hiddenOnPurpose;
         }
         super.processUpdateMessage(param1);
         if(object != null)
         {
            if(_hiddenOnPurpose)
            {
               object.setState(1,0);
            }
            else if(!_loc2_.visible)
            {
               object.setState(1,0);
            }
            else
            {
               _loc3_ = _loc2_.height;
               object.getModelController().setNumber("tile_cursor_height",_loc3_);
               _loc4_ = _loc3_ > 0.8 ? 6 : 0;
               object.setState(_loc4_,0);
            }
         }
         var_3660 = _loc2_.sourceEventId;
      }
   }
}

