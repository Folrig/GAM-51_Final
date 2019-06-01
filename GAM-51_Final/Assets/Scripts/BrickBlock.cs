using UnityEngine;
/// <summary>
/// A helper script to ensure all bricks with rigidbodies are set with no floating point error
/// </summary>
public class BrickBlock : MonoBehaviour
{
    #region Methods
    private void Awake()
    {
        Mathf.RoundToInt(this.transform.position.x);
        Mathf.RoundToInt(this.transform.position.y);
        Mathf.RoundToInt(this.transform.position.z);
    }
    #endregion
}
