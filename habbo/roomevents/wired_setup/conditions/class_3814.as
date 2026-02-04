package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3814 extends DefaultConditionType
   {
      
      private var _cont:class_1812;
      
      public function class_3814()
      {
         super();
      }
      
      private static function select(param1:class_1885, param2:Boolean) : void
      {
         if(param2)
         {
            param1.select();
         }
         else
         {
            param1.unselect();
         }
      }
      
      override public function get code() : int
      {
         return class_4100.USER_DIRECTION;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         param3.refreshButton(param1,"move_0",true,null,0);
         param3.refreshButton(param1,"move_1",true,null,0);
         param3.refreshButton(param1,"move_2",true,null,0);
         param3.refreshButton(param1,"move_3",true,null,0);
         param3.refreshButton(param1,"move_4",true,null,0);
         param3.refreshButton(param1,"move_5",true,null,0);
         param3.refreshButton(param1,"move_6",true,null,0);
         param3.refreshButton(param1,"move_7",true,null,0);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc4_:int = 0;
         var _loc2_:class_1885 = null;
         var _loc3_:* = false;
         var _loc5_:int = int(param1.intParams[0]);
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = getDirectionCheckbox(_loc4_);
            _loc3_ = (_loc5_ & 1 << _loc4_) > 0;
            select(_loc2_,_loc3_);
            _loc4_++;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc3_:int = 0;
         var _loc2_:class_1885 = null;
         var _loc1_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < 8)
         {
            _loc2_ = getDirectionCheckbox(_loc3_);
            if(_loc2_.isSelected)
            {
               var _loc4_:* = 0 | 1 << _loc3_;
            }
            _loc3_++;
         }
         _loc1_.push(0);
         return _loc1_;
      }
      
      private function getDirectionCheckbox(param1:int) : class_1885
      {
         return class_1885(_cont.findChildByName("dir_" + param1 + "_checkbox"));
      }
   }
}

