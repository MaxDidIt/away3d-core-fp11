package away3d.materials.passes
{
	import away3d.arcane;
	import away3d.cameras.Camera3D;
	import away3d.core.managers.Stage3DProxy;
	import away3d.materials.compilation.ShaderCompiler;
	import away3d.materials.compilation.SuperShaderCompiler;
	import away3d.materials.MaterialBase;
	import away3d.materials.passes.CompiledPass;
	import away3d.materials.passes.MaterialPassBase;
	import away3d.materials.passes.SuperShaderPass;
	import flash.display.BlendMode;
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DCompareMode;
	
	use namespace arcane;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SilhouettePass extends CompiledPass 
	{
		/**
		 * Creates a new SilhouettePass object.
		 */
		public function SilhouettePass(material:MaterialBase) 
		{
			super(material);
			
			this.setBlendMode(BlendMode.LAYER);
			_depthCompareMode = Context3DCompareMode.GREATER;
		}
		
		override protected function createCompiler(profile:String):ShaderCompiler 
		{
			return new SuperShaderCompiler(profile);
		}
		
		override arcane function activate(stage3DProxy:Stage3DProxy, camera:Camera3D):void
		{
			super.activate(stage3DProxy, camera);
			stage3DProxy._context3D.setDepthTest(false, _depthCompareMode);
		}
	}

}