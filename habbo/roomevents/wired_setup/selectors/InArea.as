package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.room.IRoomAreaSelectionManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   
   public class InArea extends DefaultSelectorType
   {
      
      private var var_59:HabboUserDefinedRoomEvents;
      
      private var _cont:class_1812;
      
      private var var_1003:IRoomAreaSelectionManager;
      
      private var var_1509:int;
      
      private var var_1754:int;
      
      private var _width:int;
      
      private var var_385:int;
      
      private var var_798:Boolean = false;
      
      public function InArea()
      {
         super();
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var_59 = param3;
         _cont = param1;
         var_1003 = var_59.roomEngine.areaSelectionManager;
         Util.setProcDirectly(getSelectButton(),onSelect);
         Util.setProcDirectly(getClearButton(),onClear);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         if(!var_798)
         {
            var_798 = var_1003.activate(onAreaSelected,"highlight_brighten");
         }
         var_1509 = param1.intParams[0];
         var_1754 = param1.intParams[1];
         _width = param1.intParams[2];
         var_385 = param1.intParams[3];
         if(var_798)
         {
            var_1003.setHighlight(var_1509,var_1754,_width,var_385);
            getSelectButton().enable();
            getClearButton().enable();
         }
         else
         {
            getSelectButton().disable();
            getClearButton().disable();
         }
      }
      
      override public function onEditEnd() : void
      {
         super.onEditEnd();
         if(var_798)
         {
            var_1003.deactivate();
            var_798 = false;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1509);
         _loc1_.push(var_1754);
         _loc1_.push(_width);
         _loc1_.push(var_385);
         return _loc1_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getSelectButton() : class_1775
      {
         return _cont.findChildByName("select_button") as class_1775;
      }
      
      private function getClearButton() : class_1775
      {
         return _cont.findChildByName("clear_button") as class_1775;
      }
      
      private function onSelect(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         getSelectButton().disable();
         var_1003.startSelecting();
      }
      
      private function onClear(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var_1003.clearHighlight();
      }
      
      private function onAreaSelected(param1:int, param2:int, param3:int, param4:int) : void
      {
         getSelectButton().enable();
         var_1509 = param1;
         var_1754 = param2;
         _width = param3;
         var_385 = param4;
      }
   }
}

