package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class class_3773 extends DefaultActionType
   {
      
      private var _section1:SectionPreset;
      
      private var var_3253:DropdownPreset;
      
      private var _section2:SectionPreset;
      
      private var var_2719:TextInputPreset;
      
      public function class_3773()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.var_5301;
      }
      
      override public function get negativeCode() : int
      {
         return class_4061.var_5348;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_3253.selectedId);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         return var_2719.text;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_3253.selectedId = param1.getInt(0);
         var_2719.text = param1.stringParam;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:TextualButtonPreset = param1.createTextualButtonPreset("${wiredfurni.params.write_to_logs.view}",viewLogsCallback);
         var _loc5_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc5_.push(new ExpandableDropdownOption(0,"${wiredfurni.params.write_to_logs.log_level.0}"));
         _loc5_.push(new ExpandableDropdownOption(1,"${wiredfurni.params.write_to_logs.log_level.1}"));
         _loc5_.push(new ExpandableDropdownOption(2,"${wiredfurni.params.write_to_logs.log_level.2}"));
         _loc5_.push(new ExpandableDropdownOption(3,"${wiredfurni.params.write_to_logs.log_level.3}"));
         var_3253 = param1.createDropdown(new DropdownParam("${wiredfurni.params.write_to_logs.log_level.title}",_loc5_));
         _section1 = param1.createSection("${wiredfurni.params.write_to_logs.log_level.title}",var_3253);
         var_2719 = param1.createTextInput(new TextInputParam("",400));
         _section2 = param1.createSection("${wiredfurni.params.write_to_logs.log_message.title}",var_2719);
         param3.addElements(_loc4_.alignCenter(),_section1,_section2);
      }
      
      private function viewLogsCallback() : void
      {
         roomEvents.context.createLinkEvent("wiredmenu/logs");
      }
   }
}

