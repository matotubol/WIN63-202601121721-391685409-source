package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import package_189.class_4078;
   
   public class class_3681 extends DefaultElement implements class_2404
   {
      
      private var _initialVariableName:String;
      
      public function class_3681()
      {
         super();
      }
      
      protected static function isVariableStored(param1:int) : Boolean
      {
         return param1 == class_4078.var_3636 || param1 == class_4078.var_3714;
      }
      
      public function set initialVariableName(param1:String) : void
      {
         _initialVariableName = param1;
         variableNameSection.variableName = param1;
      }
      
      public function get initialVariableName() : String
      {
         return _initialVariableName;
      }
      
      public function variableType() : int
      {
         return 0;
      }
      
      protected function get variableNameSection() : VariableNameSection
      {
         return null;
      }
   }
}

