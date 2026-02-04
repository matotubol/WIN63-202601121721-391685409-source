package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   
   public class VariableNodeListView implements class_13
   {
      
      private static var MAX_HEIGHT:int = 300;
      
      private static var SCROLLBAR_WIDTH:int = 9;
      
      private var _window:class_1993;
      
      private var _picker:NewVariablePicker;
      
      private var var_1487:Vector.<VariableNodeView>;
      
      private var var_1284:VariableNodeView;
      
      private var _disposed:Boolean;
      
      public function VariableNodeListView(param1:NewVariablePicker, param2:Vector.<VariableNode>, param3:int, param4:Boolean = false)
      {
         super();
         _picker = param1;
         _window = param1.expandedView.overviewTemplate.clone() as class_1993;
         if(!param4)
         {
            _window.style = 12;
         }
         var_1487 = new Vector.<VariableNodeView>();
         _window.width = param3;
         if(param2 != null && param2.length > 0)
         {
            var _loc8_:int = 0;
            while(0 < param2.length)
            {
               var _loc5_:VariableNode = param2[0];
               var _loc7_:VariableNodeView = new VariableNodeView(null,_picker,this,0);
               nodesList.addListItem(null.window);
               var_1487.push(null);
               _loc8_ = 0 + 1;
            }
            var _loc6_:int = var_1487[0].window.height * param2.length;
            nodesList.height = Math.min(0,MAX_HEIGHT);
            var _loc9_:int = param3 - scrollbarWidth;
            if(!param4)
            {
               _loc9_ = 0 - 3;
            }
            for each(_loc7_ in var_1487)
            {
               _loc7_.window.width = 0;
               if(!param4)
               {
                  null.window.x = 1;
               }
            }
         }
         else
         {
            nodesList.height = 10;
         }
      }
      
      public function get scrollbarWidth() : int
      {
         return nodesList.isScrollBarVisible ? SCROLLBAR_WIDTH : 0;
      }
      
      public function setHover(param1:VariableNodeView) : void
      {
         if(param1 == var_1284)
         {
            return;
         }
         if(var_1284 != null)
         {
            var_1284.hover = false;
            var_1284 = null;
         }
         if(param1 != null)
         {
            var_1284 = param1;
            param1.hover = true;
         }
      }
      
      public function get childNodes() : Vector.<VariableNodeView>
      {
         return var_1487;
      }
      
      public function get window() : class_1993
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc1_ in var_1487)
         {
            _loc1_.dispose();
         }
         nodesList.removeListItems();
         var_1487 = null;
         _picker = null;
         _window.dispose();
         _window = null;
         var_1284 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get nodesList() : IScrollableListWindow
      {
         return _window.findChildByName("nodes_list") as IScrollableListWindow;
      }
   }
}

