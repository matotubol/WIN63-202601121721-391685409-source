package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3705 extends DefaultSelectorType
   {
      
      private var _cont:class_1812;
      
      public function class_3705()
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
         return SelectorCodes.FURNI_BY_TYPE;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         select(getStateInput(),param1.getBoolean(0));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getStateInput().isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getStateInput() : class_1885
      {
         return class_1885(_cont.findChildByName("state_checkbox"));
      }
   }
}

