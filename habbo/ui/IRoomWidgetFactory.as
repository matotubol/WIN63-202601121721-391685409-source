package com.sulake.habbo.ui
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   
   public interface IRoomWidgetFactory extends class_13
   {
      
      function createWidget(param1:String, param2:IRoomWidgetHandler) : IRoomWidget;
   }
}

