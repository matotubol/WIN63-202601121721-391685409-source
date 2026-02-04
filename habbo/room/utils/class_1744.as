package com.sulake.habbo.room.utils
{
   import com.sulake.core.utils.class_55;
   
   [SecureSWF(rename="true")]
   public class class_1744
   {
      
      private var var_1951:int = 0;
      
      private var var_849:class_1934 = null;
      
      private var _legacyGeometry:class_1821 = null;
      
      private var var_1351:class_2247 = null;
      
      private var var_1827:class_1771 = null;
      
      private var _selectedObject:class_1925 = null;
      
      private var _placedObject:class_1925 = null;
      
      private var var_4728:String = null;
      
      private var var_971:class_55 = new class_55();
      
      private var var_912:class_55 = new class_55();
      
      private var _mouseButtonCursorOwners:Array = [];
      
      public function class_1744(param1:int)
      {
         super();
         var_1951 = param1;
         _legacyGeometry = new class_1821();
         var_1827 = new class_1771();
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
      
      public function get furniStackingHeightMap() : class_1934
      {
         return var_849;
      }
      
      public function set furniStackingHeightMap(param1:class_1934) : void
      {
         if(var_849 != null)
         {
            var_849.dispose();
         }
         var_849 = param1;
         if(var_1351)
         {
            var_1351.dispose();
         }
         if(var_849)
         {
            var_1351 = new class_2247(var_849.width,var_849.height);
         }
      }
      
      public function get legacyGeometry() : class_1821
      {
         return _legacyGeometry;
      }
      
      public function get tileObjectMap() : class_2247
      {
         return var_1351;
      }
      
      public function get roomCamera() : class_1771
      {
         return var_1827;
      }
      
      public function get worldType() : String
      {
         return var_4728;
      }
      
      public function set worldType(param1:String) : void
      {
         var_4728 = param1;
      }
      
      public function get selectedObject() : class_1925
      {
         return _selectedObject;
      }
      
      public function set selectedObject(param1:class_1925) : void
      {
         if(_selectedObject != null)
         {
            _selectedObject.dispose();
         }
         _selectedObject = param1;
      }
      
      public function get placedObject() : class_1925
      {
         return _placedObject;
      }
      
      public function set placedObject(param1:class_1925) : void
      {
         if(_placedObject != null)
         {
            _placedObject.dispose();
         }
         _placedObject = param1;
      }
      
      public function dispose() : void
      {
         if(var_849 != null)
         {
            var_849.dispose();
            var_849 = null;
         }
         if(_legacyGeometry != null)
         {
            _legacyGeometry.dispose();
            _legacyGeometry = null;
         }
         if(var_1827 != null)
         {
            var_1827.dispose();
            var_1827 = null;
         }
         if(_selectedObject != null)
         {
            _selectedObject.dispose();
            _selectedObject = null;
         }
         if(_placedObject != null)
         {
            _placedObject.dispose();
            _placedObject = null;
         }
         if(var_971 != null)
         {
            var_971.dispose();
            var_971 = null;
         }
         if(var_912 != null)
         {
            var_912.dispose();
            var_912 = null;
         }
         if(var_1351 != null)
         {
            var_1351.dispose();
            var_1351 = null;
         }
      }
      
      public function addFurnitureData(param1:class_2197) : void
      {
         if(param1 != null)
         {
            var_971.remove(param1.id);
            var_971.add(param1.id,param1);
         }
      }
      
      public function getFurnitureData() : class_2197
      {
         if(var_971.length > 0)
         {
            return getFurnitureDataWithId(var_971.getKey(0));
         }
         return null;
      }
      
      public function getFurnitureDataWithId(param1:int) : class_2197
      {
         return var_971.remove(param1);
      }
      
      public function addWallItemData(param1:class_2197) : void
      {
         if(param1 != null)
         {
            var_912.remove(param1.id);
            var_912.add(param1.id,param1);
         }
      }
      
      public function getWallItemData() : class_2197
      {
         if(var_912.length > 0)
         {
            return getWallItemDataWithId(var_912.getKey(0));
         }
         return null;
      }
      
      public function getWallItemDataWithId(param1:int) : class_2197
      {
         return var_912.remove(param1);
      }
      
      public function addButtonMouseCursorOwner(param1:String) : Boolean
      {
         var _loc2_:int = int(_mouseButtonCursorOwners.indexOf(param1));
         if(_loc2_ == -1)
         {
            _mouseButtonCursorOwners.push(param1);
            return true;
         }
         return false;
      }
      
      public function removeButtonMouseCursorOwner(param1:String) : Boolean
      {
         var _loc2_:int = int(_mouseButtonCursorOwners.indexOf(param1));
         if(_loc2_ > -1)
         {
            _mouseButtonCursorOwners.splice(_loc2_,1);
            return true;
         }
         return false;
      }
      
      public function hasButtonMouseCursorOwners() : Boolean
      {
         return _mouseButtonCursorOwners.length > 0;
      }
   }
}

