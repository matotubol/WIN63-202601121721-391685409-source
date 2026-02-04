package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariableNameSection extends AbstractSectionPreset
   {
      
      private var _name:TextInputPreset;
      
      public function VariableNameSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _name = param2.createTextInput(new TextInputParam("",32));
         _name.addListener(onPlaceholderChange);
         initializeSection(l("variables.variable_name"),_name);
      }
      
      private function onPlaceholderChange(param1:String) : void
      {
         var _loc2_:String = _name.text;
         var _loc3_:String = param1.split(" ").join("_").toLowerCase();
         if(_loc2_ != _loc3_)
         {
            _name.text = _loc3_;
         }
      }
      
      public function set variableName(param1:String) : void
      {
         _name.text = param1;
         onPlaceholderChange(param1);
      }
      
      public function get variableName() : String
      {
         return _name.text.split(" ").join("_").toLowerCase();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _name = null;
      }
   }
}

