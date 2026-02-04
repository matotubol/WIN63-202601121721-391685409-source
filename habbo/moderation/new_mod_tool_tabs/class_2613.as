package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.moderation.class_1852;
   
   [SecureSWF(rename="true")]
   public class class_2613 implements class_13
   {
      
      private var var_3363:class_1852;
      
      private var _window:class_1812;
      
      private var var_588:Boolean = false;
      
      private var var_1134:Boolean = false;
      
      public function class_2613(param1:class_1852, param2:class_1812)
      {
         super();
         var_3363 = param1;
         _window = param2;
         param2.visible = false;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_588 != param1)
         {
            var_588 = param1;
            _window.visible = param1;
         }
      }
      
      public function get tool() : class_1852
      {
         return var_3363;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
      
      public function onOpen() : void
      {
      }
      
      public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         _window = null;
         var_3363 = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
   }
}

