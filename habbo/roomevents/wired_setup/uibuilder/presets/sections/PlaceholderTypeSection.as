package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedTextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PlaceholderTypeSection extends AbstractSectionPreset
   {
      
      private var var_852:RadioGroupPreset;
      
      private var var_2149:NamedTextInputPreset;
      
      public function PlaceholderTypeSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String = null)
      {
         super(param1,param2,param3);
         var_2149 = param2.createNamedTextInput(new TextInputParam("",100,null,55),l("texts.select_delimiter"));
         param4 = param4 == null ? "" : param4 + ".";
         var_852 = param2.createRadioGroup([new RadioButtonParam(0,l("texts.placeholder_type." + param4 + "1")),new RadioButtonParam(1,l("texts.placeholder_type." + param4 + "2"),null,var_2149)]);
         initializeSection(l("texts.placeholder_type"),var_852);
      }
      
      public function get isShowMultiple() : Boolean
      {
         return var_852.selected == 1;
      }
      
      public function set isShowMultiple(param1:Boolean) : void
      {
         var_852.selected = param1 ? 1 : 0;
      }
      
      public function get delimiter() : String
      {
         return isShowMultiple ? var_2149.text : "";
      }
      
      public function set delimiter(param1:String) : void
      {
         var_2149.text = param1;
      }
      
      public function method_20(param1:int) : RadioButtonPreset
      {
         return var_852.method_20(param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_852 = null;
         var_2149 = null;
      }
   }
}

