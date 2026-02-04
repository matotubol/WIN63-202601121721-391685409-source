package com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications
{
   public class SubVariableParam
   {
      
      private var var_197:int;
      
      private var _name:String;
      
      public function SubVariableParam(param1:int, param2:String)
      {
         super();
         this.var_197 = param1;
         this._name = param2;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

