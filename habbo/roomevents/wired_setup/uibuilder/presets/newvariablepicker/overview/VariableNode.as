package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import package_189.WiredVariable;
   
   public class VariableNode
   {
      
      private var var_1108:WiredVariable;
      
      private var _children:class_55;
      
      private var _name:String;
      
      public function VariableNode(param1:WiredVariable, param2:String)
      {
         super();
         var_1108 = param1;
         _name = param2;
         _children = new class_55();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get variable() : WiredVariable
      {
         return var_1108;
      }
      
      public function get children() : Vector.<VariableNode>
      {
         return Vector.<VariableNode>(_children.getValues());
      }
      
      public function get childrenCount() : int
      {
         return _children.length;
      }
      
      public function getChildNodeByName(param1:String) : VariableNode
      {
         return _children.getValue(param1);
      }
      
      public function addChildNode(param1:VariableNode) : void
      {
         _children.add(param1.name,param1);
      }
      
      public function flatten(param1:Boolean = false) : Boolean
      {
         var _loc3_:VariableNode = null;
         if(_children.length == 1 && var_1108 == null)
         {
            _loc3_ = _children.getValues()[0];
            if(_loc3_.flatten())
            {
               var_1108 = _loc3_.variable;
               _children = new class_55();
            }
         }
         var _loc2_:Boolean = var_1108 != null && _children.length == 0;
         if(param1 && _loc2_)
         {
            _name = var_1108.variableName;
         }
         return _loc2_;
      }
      
      public function canBeSelected(param1:NewVariablePicker) : Boolean
      {
         if(var_1108 == null)
         {
            return false;
         }
         if(param1.variableFilter != null && !param1.variableFilter(variable))
         {
            return false;
         }
         return true;
      }
      
      public function isDisabled(param1:NewVariablePicker) : Boolean
      {
         if(canBeSelected(param1))
         {
            return false;
         }
         if(_children)
         {
            for each(var _loc2_ in _children)
            {
               if(!_loc2_.isDisabled(param1))
               {
                  return false;
               }
            }
         }
         return true;
      }
   }
}

