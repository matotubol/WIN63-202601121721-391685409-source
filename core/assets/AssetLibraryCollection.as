package com.sulake.core.assets
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.class_47;
   import com.sulake.core.utils.class_54;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class AssetLibraryCollection extends EventDispatcherWrapper implements class_40
   {
      
      protected var var_91:Vector.<class_40>;
      
      protected var var_1095:Array;
      
      protected var var_1938:LoaderContext;
      
      protected var var_1430:AssetLibrary;
      
      protected var var_598:XML;
      
      protected var _name:String;
      
      private var var_493:uint = 0;
      
      public function AssetLibraryCollection(param1:String)
      {
         super();
         _name = param1;
         var_598 = null;
         var_91 = new Vector.<class_40>();
         var_1095 = [];
         var_1938 = new LoaderContext(false,ApplicationDomain.currentDomain,null);
      }
      
      public function get url() : String
      {
         return "";
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReady() : Boolean
      {
         return var_1095.length == 0;
      }
      
      public function get numAssets() : uint
      {
         return getNumAssets();
      }
      
      public function get nameArray() : Array
      {
         return getAssetNameArray();
      }
      
      public function get manifest() : XML
      {
         return var_598 ? var_598 : (var_598 = new XML());
      }
      
      public function get loaderContext() : LoaderContext
      {
         return var_1938;
      }
      
      public function set loaderContext(param1:LoaderContext) : void
      {
         var_1938 = param1;
      }
      
      private function get binLibrary() : class_40
      {
         if(!var_1430)
         {
            var_1430 = new AssetLibrary("bin");
            var_91.splice(0,0,var_1430);
         }
         return var_1430;
      }
      
      public function loadFromFile(param1:class_47, param2:Boolean = false) : void
      {
         if(loaderContext == null)
         {
            loaderContext = var_1938;
         }
         var _loc3_:class_40 = new AssetLibrary("lib-" + var_493++);
         var_1095.push(_loc3_);
         _loc3_.loadFromFile(param1,param2);
         param1.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",loadEventHandler);
         param1.addEventListener("LIBRARY_LOADER_EVENT_ERROR",loadEventHandler);
         param1.addEventListener("LIBRARY_LOADER_EVENT_PROGRESS",loadEventHandler);
      }
      
      public function loadFromResource(param1:XML, param2:Class) : Boolean
      {
         return binLibrary.loadFromResource(param1,param2);
      }
      
      public function unload() : void
      {
         while(var_1095.length > 0)
         {
            (var_1095.pop() as class_40).dispose();
         }
         while(var_91.length > 0)
         {
            (var_91.pop() as class_40).dispose();
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:* = 0;
         var _loc1_:class_40 = null;
         var _loc3_:* = 0;
         if(!disposed)
         {
            super.dispose();
            _loc2_ = var_91.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = var_91.pop();
               _loc1_.dispose();
               _loc3_++;
            }
            var_1430 = null;
         }
      }
      
      private function loadEventHandler(param1:class_54) : void
      {
         var _loc3_:class_47 = null;
         var _loc2_:class_40 = null;
         var _loc4_:* = 0;
         if(param1.type == "LIBRARY_LOADER_EVENT_COMPLETE")
         {
            _loc3_ = param1.target as class_47;
            _loc4_ = 0;
            while(_loc4_ < var_1095.length)
            {
               _loc2_ = var_1095[_loc4_] as class_40;
               if(_loc2_.url == _loc3_.url)
               {
                  var_1095.splice(_loc4_,1);
                  break;
               }
               _loc4_++;
            }
            var_91.push(_loc2_);
            _loc3_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",loadEventHandler);
            _loc3_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",loadEventHandler);
            _loc3_.removeEventListener("LIBRARY_LOADER_EVENT_PROGRESS",loadEventHandler);
            if(var_1095.length == 0)
            {
               dispatchEvent(new Event("AssetLibraryLoaded"));
            }
         }
      }
      
      public function hasAssetLibrary(param1:String) : Boolean
      {
         for each(var _loc2_ in var_91)
         {
            if(_loc2_.name == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getAssetLibraryByName(param1:String) : class_40
      {
         for each(var _loc2_ in var_91)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAssetLibraryByUrl(param1:String) : class_40
      {
         for each(var _loc2_ in var_91)
         {
            if(_loc2_.url == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAssetLibraryByPartialUrl(param1:String) : class_40
      {
         for each(var _loc2_ in var_91)
         {
            if(_loc2_.url && _loc2_.url.indexOf(param1) !== -1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addAssetLibrary(param1:class_40) : void
      {
         if(var_91.indexOf(param1) == -1)
         {
            var_91.push(param1);
         }
      }
      
      public function removeAssetLibrary(param1:class_40) : void
      {
         var _loc2_:int = int(var_91.indexOf(param1));
         if(_loc2_ >= 0)
         {
            var_91.splice(_loc2_,1);
         }
      }
      
      public function addOrReplaceAssetLibrary(param1:class_40) : void
      {
         var _loc3_:int = 0;
         var _loc2_:class_40 = null;
         _loc3_ = 0;
         while(_loc3_ < var_91.length)
         {
            _loc2_ = var_91[_loc3_];
            if(_loc2_.name == param1.name)
            {
               var_91[_loc3_] = param1;
               return;
            }
            _loc3_++;
         }
         var_91.push(param1);
      }
      
      public function loadAssetFromFile(param1:String, param2:URLRequest, param3:String = null, param4:int = -1) : AssetLoaderStruct
      {
         return binLibrary.loadAssetFromFile(param1,param2,param3,param4);
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         var _loc3_:IAsset = null;
         for each(var _loc2_ in var_91)
         {
            _loc3_ = _loc2_.getAssetByName(param1);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getAssetsByName(param1:String) : Array
      {
         var _loc4_:IAsset = null;
         var _loc2_:Array = [];
         for each(var _loc3_ in var_91)
         {
            _loc4_ = _loc3_.getAssetByName(param1);
            if(_loc4_ != null)
            {
               _loc2_.push(_loc4_);
            }
         }
         return _loc2_;
      }
      
      public function getAssetByContent(param1:Object) : IAsset
      {
         var _loc3_:IAsset = null;
         for each(var _loc2_ in var_91)
         {
            _loc3_ = _loc2_.getAssetByContent(param1);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getAssetByIndex(param1:uint) : IAsset
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         for each(var _loc4_ in var_91)
         {
            _loc2_ += _loc4_.numAssets;
            if(_loc2_ <= param1)
            {
               return _loc4_.getAssetByIndex(param1 - _loc3_);
            }
            _loc3_ = _loc2_;
         }
         return null;
      }
      
      public function getAssetIndex(param1:IAsset) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         for each(var _loc3_ in var_91)
         {
            _loc4_ = _loc3_.getAssetIndex(param1);
            if(_loc4_ != -1)
            {
               return _loc2_ + _loc4_;
            }
            _loc2_ += _loc3_.numAssets;
         }
         return -1;
      }
      
      public function hasAsset(param1:String) : Boolean
      {
         for each(var _loc2_ in var_91)
         {
            if(_loc2_.hasAsset(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function setAsset(param1:String, param2:IAsset, param3:Boolean = true) : Boolean
      {
         return binLibrary.setAsset(param1,param2,param3);
      }
      
      public function createAsset(param1:String, param2:AssetTypeDeclaration) : IAsset
      {
         return binLibrary.createAsset(param1,param2);
      }
      
      public function removeAsset(param1:IAsset) : IAsset
      {
         for each(var _loc2_ in var_91)
         {
            if(_loc2_.removeAsset(param1) == param1)
            {
               return param1;
            }
         }
         return null;
      }
      
      public function registerAssetTypeDeclaration(param1:AssetTypeDeclaration, param2:Boolean = true) : Boolean
      {
         return binLibrary.registerAssetTypeDeclaration(param1,param2);
      }
      
      public function getAssetTypeDeclarationByMimeType(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:AssetTypeDeclaration = null;
         if(param2)
         {
            return binLibrary.getAssetTypeDeclarationByMimeType(param1,true);
         }
         for each(var _loc4_ in var_91)
         {
            _loc3_ = _loc4_.getAssetTypeDeclarationByMimeType(param1,false);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByClass(param1:Class, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:AssetTypeDeclaration = null;
         if(param2)
         {
            return binLibrary.getAssetTypeDeclarationByClass(param1,true);
         }
         for each(var _loc4_ in var_91)
         {
            _loc3_ = _loc4_.getAssetTypeDeclarationByClass(param1,false);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getAssetTypeDeclarationByFileName(param1:String, param2:Boolean = true) : AssetTypeDeclaration
      {
         var _loc3_:AssetTypeDeclaration = null;
         if(param2)
         {
            return binLibrary.getAssetTypeDeclarationByFileName(param1,true);
         }
         for each(var _loc4_ in var_91)
         {
            _loc3_ = _loc4_.getAssetTypeDeclarationByFileName(param1,false);
            if(_loc3_ != null)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function getNumAssets() : uint
      {
         var _loc1_:uint = 0;
         for each(var _loc2_ in var_91)
         {
            _loc1_ += _loc2_.numAssets;
         }
         return _loc1_;
      }
      
      private function getAssetNameArray() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in var_91)
         {
            _loc2_ = _loc2_.concat(_loc1_.nameArray);
         }
         return _loc2_;
      }
      
      public function getManifests() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_ in var_91)
         {
            _loc2_.push(_loc1_.manifest);
         }
         return _loc2_;
      }
      
      private function buildManifest() : XML
      {
         var _loc3_:XML = <manifest><library></library></manifest>;
         var _loc1_:XMLList = _loc3_.child("library");
         if(var_1430)
         {
            applyManifestNodes(_loc1_,var_1430);
         }
         for each(var _loc2_ in var_91)
         {
            applyManifestNodes(_loc1_,_loc2_);
         }
         return _loc3_;
      }
      
      private function applyManifestNodes(param1:XMLList, param2:class_40) : void
      {
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         var _loc5_:XMLList = param2.manifest.library.children();
         for each(var _loc6_ in _loc5_)
         {
            _loc3_ = param1.child(_loc6_.name())[0];
            if(!_loc3_)
            {
               param1.appendChild(new XML("<" + _loc6_.name() + "/>"));
               _loc3_ = param1.child(_loc6_.name())[0];
            }
            _loc4_ = _loc6_.children();
            for each(var _loc7_ in _loc4_)
            {
               _loc3_.appendChild(_loc7_);
            }
         }
      }
   }
}

