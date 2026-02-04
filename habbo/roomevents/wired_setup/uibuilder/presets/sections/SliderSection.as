package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.class_3672;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.class_3815;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.class_3819;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SliderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.events.Event;
   
   public class SliderSection extends AbstractSectionPreset
   {
      
      public static const CONVERTER_ECHO:class_3672 = new class_3815();
      
      public static const CONVERTER_PULSES:class_3672 = new class_3819();
      
      private var _sliderPreset:SliderPreset;
      
      private var var_2836:class_3672;
      
      private var _localizationKey:String;
      
      private var var_3939:String;
      
      private var var_1186:NumberInputPreset;
      
      private var _ignoreListeners:Boolean;
      
      public function SliderSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:class_3672, param7:Number = 0, param8:Number = 1, param9:Number = 0, param10:Boolean = true)
      {
         super(param1,param2,param3);
         var_2836 = param6;
         _localizationKey = param4;
         var_3939 = param5;
         _sliderPreset = param2.createSliderPreset(param7,param8,param9);
         var _loc11_:SectionParam = null;
         if(param10)
         {
            var_1186 = param2.createNumberInput(new NumberInputParam(0,param7,param8,40,param6.precision,param6.endsWithFive));
            var_1186.onValueChange = onTextValueChange;
            _loc11_ = new SectionParam(null,0,var_1186);
         }
         initializeSection(param1.localization.getLocalization(param4),_sliderPreset,_loc11_);
         if(!param10)
         {
            updateName();
         }
         _sliderPreset.addEventListener("change",onSliderChange);
      }
      
      private function onTextValueChange(param1:int) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         _ignoreListeners = true;
         _sliderPreset.value = param1;
         _ignoreListeners = false;
      }
      
      private function onSliderChange(param1:Event) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         if(var_1186 != null)
         {
            _ignoreListeners = true;
            var_1186.value = _sliderPreset.value;
            _ignoreListeners = false;
         }
         else
         {
            updateName();
         }
      }
      
      private function updateName() : void
      {
         var_785.titleText = localizations.getLocalizationWithParams(_localizationKey,"",var_3939,var_2836.toString(value));
      }
      
      public function get value() : int
      {
         return _sliderPreset.value;
      }
      
      public function set value(param1:int) : void
      {
         _ignoreListeners = true;
         _sliderPreset.value = param1;
         if(var_1186 != null)
         {
            var_1186.value = param1;
         }
         updateName();
         _ignoreListeners = false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _sliderPreset = null;
         var_2836 = null;
         var_1186 = null;
      }
   }
}

