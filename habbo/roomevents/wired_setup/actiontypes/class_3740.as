package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3740 extends DefaultActionType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1174:SliderWindowController;
      
      public function class_3740()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.MUTE_USER;
      }
      
      override public function readStringParamFromForm() : String
      {
         return getMessage(cont).text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1174.getValue());
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         getMessage(cont).text = param1.stringParam;
         var _loc2_:int = int(param1.intParams[0]);
         var_1174.setValue(_loc2_);
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getMessage(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("chat_message"));
      }
      
      override public function validate() : String
      {
         var _loc2_:String = null;
         if(getMessage(cont).text.length > 100)
         {
            _loc2_ = "wiredfurni.chatmsgtoolong";
            return roomEvents.localization.getLocalization(_loc2_,_loc2_);
         }
         return null;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_1174 = new SliderWindowController(param3,getSlider(param1),param3.assets,0,10,1);
         var_1174.setValue(1);
         var_1174.addEventListener("change",onSliderChange);
      }
      
      private function getSlider(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container") as class_1812;
      }
      
      protected function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc4_ = _loc2_.getValue();
               _loc3_ = (int(_loc4_)).toString();
               _roomEvents.localization.registerParameter("wiredfurni.params.length.minutes","minutes",_loc3_);
            }
         }
      }
      
      public function get slider() : SliderWindowController
      {
         return var_1174;
      }
   }
}

