package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import flash.geom.Rectangle;
   
   public class SelectableController extends InteractiveController implements ISelectableWindow
   {
      
      public function SelectableController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get selector() : ISelectorWindow
      {
         var _loc1_:class_1741 = null;
         if(_parent)
         {
            _loc1_ = _parent as WindowController;
            while(_loc1_)
            {
               if(_loc1_ is ISelectorWindow)
               {
                  return _loc1_ as ISelectorWindow;
               }
               _loc1_ = _loc1_.parent;
            }
         }
         return null;
      }
      
      public function get isSelected() : Boolean
      {
         return testStateFlag(8);
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         setStateFlag(8,param1);
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         var _loc3_:WindowController = null;
         var _loc4_:class_1758 = null;
         if(param2.type == "WE_ACTIVATED")
         {
            if(_parent)
            {
               if(!(_parent is ISelectorWindow))
               {
                  _loc3_ = _parent.parent as WindowController;
                  while(_loc3_)
                  {
                     if(_loc3_ is ISelectorWindow)
                     {
                        _loc4_ = class_1758.allocate("WE_CHILD_ACTIVATED",this,null);
                        _loc3_.update(this,_loc4_);
                        _loc4_.recycle();
                        break;
                     }
                     _loc3_ = _loc3_.parent as WindowController;
                  }
               }
            }
         }
         return super.update(param1,param2);
      }
      
      public function select() : Boolean
      {
         if(getStateFlag(8))
         {
            return true;
         }
         var _loc1_:class_1758 = class_1758.allocate("WE_SELECT",this,null,true);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(8,true);
         _loc1_ = class_1758.allocate("WE_SELECTED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         activate();
         return true;
      }
      
      public function unselect() : Boolean
      {
         if(!getStateFlag(8))
         {
            return true;
         }
         var _loc1_:class_1758 = class_1758.allocate("WE_UNSELECT",this,null,true);
         update(this,_loc1_);
         if(_loc1_.isDefaultPrevented())
         {
            _loc1_.recycle();
            return false;
         }
         _loc1_.recycle();
         setStateFlag(8,false);
         _loc1_ = class_1758.allocate("WE_UNSELECTED",this,null);
         update(this,_loc1_);
         _loc1_.recycle();
         return true;
      }
   }
}

