package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderTypeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class class_3990 extends DefaultAddonType
   {
      
      private var var_1414:PlaceholderNameSection;
      
      private var var_1165:PlaceholderTypeSection;
      
      public function class_3990()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.USERNAME_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var_1414 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         var_1165 = param1.createPlaceholderTypeSection("user");
         param3.addElements(var_1414,var_1165);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         var _loc5_:Boolean = param1.getBoolean(0);
         var _loc4_:String = _loc2_[0];
         var _loc3_:String = _loc2_.length > 1 ? _loc2_[1] : "";
         var_1414.placeholderName = _loc4_;
         var_1165.isShowMultiple = _loc5_;
         var_1165.delimiter = _loc3_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [var_1165.isShowMultiple ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         if(!var_1165.isShowMultiple)
         {
            return var_1414.placeholderName;
         }
         return var_1414.placeholderName + "\t" + var_1165.delimiter;
      }
   }
}

