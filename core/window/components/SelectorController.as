package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.iterators.SelectorIterator;
   import com.sulake.core.window.utils.IIterable;
   import com.sulake.core.window.utils.IIterator;
   import flash.geom.Rectangle;
   
   public class SelectorController extends InteractiveController implements ISelectorWindow, IIterable
   {
      
      private var _selected:ISelectableWindow;
      
      protected var var_4588:Boolean = true;
      
      public function SelectorController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get iterator() : IIterator
      {
         return new SelectorIterator(this);
      }
      
      override public function update(param1:WindowController, param2:class_1758) : Boolean
      {
         if(param2.type == "WE_CHILD_ACTIVATED")
         {
            if(param1 is ISelectableWindow)
            {
               setSelected(param1 as ISelectableWindow);
            }
         }
         return super.update(param1,param2);
      }
      
      public function get numSelectables() : uint
      {
         return numChildren;
      }
      
      public function getSelected() : ISelectableWindow
      {
         return _selected as ISelectableWindow;
      }
      
      public function setSelected(param1:ISelectableWindow) : void
      {
         var _loc2_:ISelectableWindow = null;
         if(param1 != null)
         {
            if(param1 != _selected)
            {
               if(_selected != null)
               {
                  if(!_selected.unselect())
                  {
                     return;
                  }
               }
               _loc2_ = _selected;
               _selected = param1;
               if(_selected.select())
               {
                  if(getChildIndex(param1) > -1)
                  {
                     if(var_4588)
                     {
                        if(getChildIndex(param1) != numChildren - 1)
                        {
                           setChildIndex(param1,numChildren - 1);
                        }
                     }
                  }
               }
               else
               {
                  _selected = _loc2_;
                  if(_selected != null)
                  {
                     _selected.select();
                  }
               }
            }
         }
      }
      
      public function addSelectable(param1:ISelectableWindow) : ISelectableWindow
      {
         return ISelectableWindow(addChild(param1));
      }
      
      public function addSelectableAt(param1:ISelectableWindow, param2:int) : ISelectableWindow
      {
         return ISelectableWindow(addChildAt(param1,param2));
      }
      
      public function getSelectableAt(param1:int) : ISelectableWindow
      {
         return getChildAt(param1) as ISelectableWindow;
      }
      
      public function getSelectableByID(param1:uint) : ISelectableWindow
      {
         return getChildByID(param1) as ISelectableWindow;
      }
      
      public function getSelectableByTag(param1:String) : ISelectableWindow
      {
         return getChildByTag(param1) as ISelectableWindow;
      }
      
      public function getSelectableByName(param1:String) : ISelectableWindow
      {
         return getChildByName(param1) as ISelectableWindow;
      }
      
      public function getSelectableIndex(param1:ISelectableWindow) : int
      {
         return getChildIndex(param1);
      }
      
      public function removeSelectable(param1:ISelectableWindow) : ISelectableWindow
      {
         var _loc2_:int = getChildIndex(param1);
         if(_loc2_ > -1)
         {
            if(param1 == _selected)
            {
               if(numSelectables > 1)
               {
                  setSelected(getSelectableAt(_loc2_ == 0 ? 1 : 0));
               }
               else
               {
                  _selected = null;
               }
            }
            return ISelectableWindow(removeChild(param1));
         }
         return null;
      }
   }
}

