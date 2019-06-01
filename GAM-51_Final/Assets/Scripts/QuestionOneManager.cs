using UnityEngine;
using UnityEngine.UI;

public class QuestionOneManager : MonoBehaviour
{
    #region Variables
    public Bomb bomb;
    public InputField forceInput;
    public InputField radiusInput;
    public Button startButton;
    #endregion

    #region Methods
    public void StartSimulation()
    {
        GetBombValues();
        Explode();
    }

    private void GetBombValues()
    {
        bomb.force = float.Parse(forceInput.text);
        bomb.radius = float.Parse(radiusInput.text);
    }

    private void Explode()
    {
        Collider[] targets = Physics.OverlapSphere(bomb.transform.position, bomb.radius);
        foreach (Collider target in targets)
        {
            Rigidbody rb = target.GetComponent<Rigidbody>();
            if (rb != null)
            {
                rb.AddExplosionForce(bomb.force, bomb.transform.position, bomb.radius);
            }
        }
    }
    #endregion
}
