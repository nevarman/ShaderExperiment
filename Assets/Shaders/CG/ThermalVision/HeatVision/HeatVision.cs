using UnityEngine;
using System.Collections;
[ExecuteInEditMode]
[AddComponentMenu("Image Effects/Vision/HeatVision")]
public class HeatVision : MonoBehaviour {
	public delegate void OnHeatVisionEnabledDelegate(bool enabled);
	public static event OnHeatVisionEnabledDelegate onHeatVisionEnabled;
	/// Provides a shader property that is set in the inspector
	/// and a material instantiated from the shader
	public Shader  shader;
	[Range(0.1f,.9f)]
	public float _ColorAmplification= .4f;
	private Material m_Material;
	void OnEnable()
	{
		if(onHeatVisionEnabled!=null)onHeatVisionEnabled(true);
	}
	protected virtual void Start ()
	{
		// Disable if we don't support image effects
		if (!SystemInfo.supportsImageEffects) {
			enabled = false;
			return;
		}
		if(shader == null)shader = Shader.Find("Hidden/ThermalVision2");
		// Disable the image effect if the shader can't
		// run on the users graphics card
		if (!shader || !shader.isSupported)
			enabled = false;
	}
	
	protected Material material {
		get {
			if (m_Material == null) {
				m_Material = new Material (shader);
				m_Material.hideFlags = HideFlags.HideAndDontSave;
			}
			return m_Material;
		} 
	}
	
	protected virtual void OnDisable() {
		if( m_Material ) {
			DestroyImmediate( m_Material );
		}
		if(onHeatVisionEnabled!=null)onHeatVisionEnabled(false);
	}
	void OnRenderImage (RenderTexture source, RenderTexture destination) {
		material.SetFloat("_ColorAmplification",_ColorAmplification);
		Graphics.Blit (source, destination, material);
	}
	
}
