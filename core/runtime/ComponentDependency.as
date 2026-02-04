package com.sulake.core.runtime
{
   public class ComponentDependency
   {
      
      private var var_3099:IID;
      
      private var var_4519:Function;
      
      private var var_4334:Boolean;
      
      private var _eventListeners:Array;
      
      public function ComponentDependency(param1:IID, param2:Function, param3:Boolean = true, param4:Array = null)
      {
         super();
         var_3099 = param1;
         var_4519 = param2;
         var_4334 = param3;
         _eventListeners = param4;
      }
      
      internal function get identifier() : IID
      {
         return var_3099;
      }
      
      internal function get dependencySetter() : Function
      {
         return var_4519;
      }
      
      internal function get isRequired() : Boolean
      {
         return var_4334;
      }
      
      internal function get eventListeners() : Array
      {
         return _eventListeners;
      }
   }
}

