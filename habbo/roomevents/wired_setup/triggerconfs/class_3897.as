package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class class_3897 extends DefaultTriggerConf
   {
      
      private var var_1174:SliderSection;
      
      public function class_3897()
      {
         super();
      }
      
      public static function getSecsFromPulses(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 2);
         if(param1 % 2 == 0)
         {
            return "" + _loc2_;
         }
         return _loc2_ + ".5";
      }
      
      override public function get code() : int
      {
         return class_4093.TRIGGER_ONCE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var_1174 = param1.createSliderSection("wiredfurni.params.settime2","",SliderSection.CONVERTER_PULSES,1,1200,1);
         param3.addElements(var_1174);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_1174.value = param1.getInt(0);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [var_1174.value];
      }
   }
}

